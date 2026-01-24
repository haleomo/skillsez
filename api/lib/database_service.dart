import 'dart:io';
import 'package:dotenv/dotenv.dart';
import 'package:mysql_client_plus/mysql_client_plus.dart';

/// Service for managing database connections and queries
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  Map<String, String> _settings = {};
  bool _isInitialized = false;
  
  factory DatabaseService() {
    return _instance;
  }
  
  DatabaseService._internal();
  
  /// Initialize database connection settings
  Future<void> initialize() async {
    print('[DatabaseService] Initialize called, _isInitialized=$_isInitialized');
    
    if (_isInitialized) {
      // Already initialized
      print('[DatabaseService] Already initialized, returning');
      return;
    }
    
    try {
      print('[DatabaseService] Loading configuration...');
      // Load from environment variables or .env file
      String? dbHost = Platform.environment['DB_HOST'];
      int? dbPort = int.tryParse(Platform.environment['DB_PORT'] ?? '');
      String? dbUser = Platform.environment['DB_USER'];
      String? dbPassword = Platform.environment['DB_PASSWORD'];
      String? dbName = Platform.environment['DB_NAME'];
      
      print('[DatabaseService] Environment variables - Host: $dbHost, User: $dbUser, Name: $dbName');
      
      // If not in environment, try loading from .env file
      if (dbHost == null || dbUser == null || dbPassword == null || dbName == null) {
        print('[DatabaseService] Some variables missing, loading from .env file...');
        final env = DotEnv()..load();
        dbHost ??= env['DB_HOST'] ?? 'localhost';
        dbPort ??= int.tryParse(env['DB_PORT'] ?? '3306') ?? 3306;
        dbUser ??= env['DB_USER'] ?? 'skills-ez';
        dbPassword ??= env['DB_PASSWORD'] ?? '';
        dbName ??= env['DB_NAME'] ?? 'skills_ez';
        print('[DatabaseService] After .env - Host: $dbHost, User: $dbUser, Name: $dbName');
      }
      
      dbPort ??= 3306;
      
      print('[DatabaseService] Storing connection settings for $dbHost:$dbPort/$dbName as $dbUser...');
      
      _settings = {
        'host': dbHost,
        'port': dbPort.toString(),
        'userName': dbUser,
        'password': dbPassword,
        'databaseName': dbName,
      };
      
      _isInitialized = true;
      print('[DatabaseService] Settings: $_settings');
      
      print('Database settings configured successfully');
    } catch (e) {
      print('Database configuration failed: $e');
      rethrow;
    }
  }

  /// Executes a query using a fresh connection (opens and closes per query)
  /// Supports positional params ('?') by converting to named params for mysql_client_plus.
  Future<IResultSet> query(String sql, [List<Object?>? params]) async {
    if (_settings.isEmpty) {
      throw Exception('Database not initialized. Call initialize() first ${_settings}.');
    }
    
    MySQLConnection? conn;
    try {
      conn = await MySQLConnection.createConnection(
        host: _settings['host'] ?? 'localhost',
        port: int.tryParse(_settings['port'] ?? '3306') ?? 3306,
        userName: _settings['userName'] ?? '',
        password: _settings['password'] ?? '',
        databaseName: _settings['databaseName'] ?? '',
      );
      await conn.connect();
      if (params != null && params.isNotEmpty) {
        final converted = _convertPositionalToNamed(sql, params);
        return await conn.execute(converted.sql, converted.params);
      } else {
        return await conn.execute(sql);
      }
    } catch(e) {
      print('[DatabaseService] Error executing query: $e');
      throw Exception('Error executing query (Database Service): $e');
    } finally {
      await conn?.close();
    }
  }

  /// Executes an INSERT and returns the generated auto-increment ID.
  /// Uses a single connection for both INSERT and LAST_INSERT_ID() query.
  Future<int> insert(String sql, List<Object?> params) async {
    if (_settings.isEmpty) {
      throw Exception('Database not initialized. Call initialize() first.');
    }
    
    MySQLConnection? conn;
    try {
      conn = await MySQLConnection.createConnection(
        host: _settings['host'] ?? 'localhost',
        port: int.tryParse(_settings['port'] ?? '3306') ?? 3306,
        userName: _settings['userName'] ?? '',
        password: _settings['password'] ?? '',
        databaseName: _settings['databaseName'] ?? '',
      );
      await conn.connect();
      
      // Execute INSERT
      final converted = _convertPositionalToNamed(sql, params);
      await conn.execute(converted.sql, converted.params);
      
      // Get LAST_INSERT_ID on the SAME connection
      final rs = await conn.execute('SELECT LAST_INSERT_ID() AS id');
      final row = rs.rows.first;
      final rawId = row.colByName('id');
      print('[DatabaseService] Inserted ID row: $row rawId: $rawId');
      
      final idStr = rawId?.toString() ?? '0';
      return int.tryParse(idStr) ?? 0;
    } catch(e) {
      print('[DatabaseService] Error executing insert: $e');
      throw Exception('Error executing insert: $e');
    } finally {
      await conn?.close();
    }
  }

  /// Convert positional '?' placeholders to named placeholders with a params map
  /// Example: 'INSERT ... VALUES (?, ?)' + [a,b] -> 'INSERT ... VALUES (:p1, :p2)', {'p1': a, 'p2': b}
  _ConvertedSql _convertPositionalToNamed(String sql, List<Object?> params) {
    var index = 0;
    final buffer = StringBuffer();
    for (int i = 0; i < sql.length; i++) {
      final ch = sql[i];
      if (ch == '?' && index < params.length) {
        index++;
        buffer.write(':p$index');
      } else {
        buffer.write(ch);
      }
    }
    final map = <String, dynamic>{};
    for (int i = 0; i < params.length; i++) {
      map['p${i + 1}'] = params[i];
    }
    return _ConvertedSql(buffer.toString(), map);
  }

  /// Close method (clears settings)
  Future<void> close() async {
    _isInitialized = false;
    _settings = {};
    print('Database settings cleared');
  }
}

class _ConvertedSql {
  final String sql;
  final Map<String, dynamic> params;
  _ConvertedSql(this.sql, this.params);
}

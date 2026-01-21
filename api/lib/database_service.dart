import 'dart:io';
import 'package:dotenv/dotenv.dart';
import 'package:mysql1/mysql1.dart';

/// Service for managing database connections and queries
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  ConnectionSettings? _settings;
  bool _isInitialized = false;
  
  factory DatabaseService() {
    return _instance;
  }
  
  DatabaseService._internal();
  
  /// Initialize database connection settings
  Future<void> initialize() async {
    print('[DatabaseService] Initialize called, _isInitialized=$_isInitialized');
    
    if (_isInitialized && _settings != null) {
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
      
      _settings = ConnectionSettings(
        host: dbHost,
        port: dbPort,
        user: dbUser,
        password: dbPassword,
        db: dbName,
      );
      
      _isInitialized = true;
      print('Database settings configured successfully');
    } catch (e) {
      print('Database configuration failed: $e');
      rethrow;
    }
  }

  /// Executes a query using a fresh connection (opens and closes per query)
  Future<Results> query(String sql, [List<Object?>? params]) async {
    if (_settings == null) {
      throw Exception('Database not initialized. Call initialize() first.');
    }
    
    MySqlConnection? conn;
    try {
      conn = await MySqlConnection.connect(_settings!);
      return await conn.query(sql, params ?? const []);
    } finally {
      await conn?.close();
    }
  }
  
  /// Close method (clears settings)
  Future<void> close() async {
    _isInitialized = false;
    _settings = null;
    print('Database settings cleared');
  }
}

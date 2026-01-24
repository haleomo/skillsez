import 'dart:convert';
import 'package:api/database_service.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:shared/shared.dart';

/// GET /user/[id]
/// Retrieves a user by ID
Future<Response> onRequest(RequestContext context, String id) async {
  if (context.request.method != HttpMethod.get) {
    return Response(
      statusCode: 405,
      headers: _corsHeaders(),
      body: jsonEncode({'error': 'Method not allowed'}),
    );
  }

  try {
    final userId = int.parse(id);
    
    final db = DatabaseService();

    print('[[id].dart] Get user $userId request received');
    final results = await db.query(
      'SELECT id, email, last_name, created_at FROM skillsez_user WHERE id = ?',
      [userId],
    );
    
    if (results.rows.isEmpty) {
      return Response(
        statusCode: 404,
        headers: _corsHeaders(),
        body: jsonEncode({'error': '[[id].dart] User not found'}),
      );
    }
    
    final row = results.rows.first;
    final user = User(
      id: int.parse((row.colByName('id'))?.toString() ?? '0'),
      email: (row.colByName('email'))?.toString() ?? '',
      lastName: (row.colByName('last_name'))?.toString() ?? '',
      createdAt: DateTime.tryParse((row.colByName('created_at'))?.toString() ?? ''),
    );

    return Response(
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        ..._corsHeaders(),
      },
      body: jsonEncode({
        'success': true,
        'data': user.toJson()
      }),
    );
  } catch (e) {
    if (e is FormatException) {
      return Response(
        statusCode: 400,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'Invalid user ID format'}),
      );
    }
    
    return Response(
      statusCode: 500,
      headers: _corsHeaders(),
      body: jsonEncode({'error': 'Internal server error: ${e.toString()}'}),
    );
  }
}

Map<String, String> _corsHeaders() {
  return {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type, Authorization',
  };
}

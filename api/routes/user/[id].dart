import 'dart:convert';
import 'package:api/database_service.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:shared/shared.dart';

/// GET /user/[id] - Retrieves a user by ID
/// PUT /user/[id] - Updates a user's email and/or last name
Future<Response> onRequest(RequestContext context, String id) async {
  // Handle CORS preflight
  if (context.request.method == HttpMethod.options) {
    return Response(
      statusCode: 200,
      headers: _corsHeaders(),
    );
  }

  if (context.request.method == HttpMethod.get) {
    return _handleGet(context, id);
  } else if (context.request.method == HttpMethod.put) {
    return _handlePut(context, id);
  } else {
    return Response(
      statusCode: 405,
      headers: _corsHeaders(),
      body: jsonEncode({'error': 'Method not allowed'}),
    );
  }
}

/// Handle GET request
Future<Response> _handleGet(RequestContext context, String id) async {

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
      id: int.parse(row.colByName('id')?.toString() ?? '0'),
      email: row.colByName('email')?.toString() ?? '',
      lastName: row.colByName('last_name')?.toString() ?? '',
      createdAt: DateTime.tryParse(row.colByName('created_at')?.toString() ?? ''),
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
      body: jsonEncode({'error': '[GET /user/$id] Internal server error: $e'}),
    );
  }
}

/// Handle PUT request to update user
Future<Response> _handlePut(RequestContext context, String id) async {
  try {
    final userId = int.parse(id);
        
    final body = await context.request.body();
        
    final Map<String, dynamic> requestData = jsonDecode(body) as Map<String, dynamic>;
        
    final db = DatabaseService();
        
    // Ensure database is initialized
    await db.initialize();

    // First verify the user exists
    final checkResults = await db.query(
      'SELECT id FROM skillsez_user WHERE id = ?',
      [userId],
    );
    
    if (checkResults.rows.isEmpty) {
      return Response(
        statusCode: 404,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'User not found'}),
      );
    }

    // Build dynamic update query based on provided fields
    final updates = <String>[];
    final params = <dynamic>[];
    
    if (requestData.containsKey('email')) {
      updates.add('email = ?');
      params.add(requestData['email']);
    }
    
    if (requestData.containsKey('lastName')) {
      updates.add('last_name = ?');
      params.add(requestData['lastName']);
    }
    
    if (updates.isEmpty) {
      return Response(
        statusCode: 400,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'No valid fields to update'}),
      );
    }
    
    // Add userId to params for WHERE clause
    params.add(userId);
    
    final updateQuery = 'UPDATE skillsez_user SET ${updates.join(', ')} WHERE id = ?';
    print('[PUT /user/$id] Executing: $updateQuery with params: $params');
    
    await db.query(updateQuery, params);
    
    // Fetch and return updated user
    final results = await db.query(
      'SELECT id, email, last_name, created_at FROM skillsez_user WHERE id = ?',
      [userId],
    );
    
    final row = results.rows.first;
    final user = User(
      id: int.parse(row.colByName('id')?.toString() ?? '0'),
      email: row.colByName('email')?.toString() ?? '',
      lastName: row.colByName('last_name')?.toString() ?? '',
      createdAt: DateTime.tryParse(row.colByName('created_at')?.toString() ?? ''),
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
    print('[PUT /user/$id] Error occurred: $e');
    print('[PUT /user/$id] Error type: ${e.runtimeType}');
    
    if (e is FormatException) {
      return Response(
        statusCode: 400,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'Invalid request format'}),
      );
    }
    
    return Response(
      statusCode: 500,
      headers: _corsHeaders(),
      body: jsonEncode({'error': '[PUT /user/$id] Internal server error: $e'}),
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

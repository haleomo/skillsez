import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:shared/shared.dart';
import '../../lib/database_service.dart';

/// POST /user
/// Creates a new user in the database
Future<Response> onRequest(RequestContext context) async {
  print('[User Route] Request received: ${context.request.method}');
  
  // Handle CORS preflight requests
  if (context.request.method == HttpMethod.options) {
    print('[User Route] Handling OPTIONS request');
    return Response(
      statusCode: 200,
      headers: _corsHeaders(),
    );
  }
  
  // Only allow POST requests
  if (context.request.method != HttpMethod.post) {
    print('[User Route] Method not allowed: ${context.request.method}');
    return Response(
      statusCode: 405,
      headers: _corsHeaders(),
      body: jsonEncode({'error': 'Method not allowed'}),
    );
  }

  try {
    print('[User Route] Reading request body...');
    final body = await context.request.body();
    print('[User Route] Body: $body');
    
    final Map<String, dynamic> requestData = jsonDecode(body) as Map<String, dynamic>;
    print('[User Route] Parsed JSON: $requestData');
    
    // Validate required fields
    final email = requestData['email'] as String?;
    final lastName = requestData['lastName'] as String?;
    
    print('[User Route] Email: $email, LastName: $lastName');
    
    if (email == null || email.trim().isEmpty) {
      print('[User Route] Email validation failed');
      return Response(
        statusCode: 400,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'Email is required'}),
      );
    }
    
    if (lastName == null || lastName.trim().isEmpty) {
      print('[User Route] LastName validation failed');
      return Response(
        statusCode: 400,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'Last name is required'}),
      );
    }

    // Insert user into database
    print('[User Route] Getting database service...');
    final db = DatabaseService();
    print('[User Route] Executing query...');
    final result = await db.connection.query(
      'INSERT INTO skillsez_user (email, last_name, created_at) VALUES (?, ?, NOW())',
      [email, lastName],
    );
    print('[User Route] Query executed, insert ID: ${result.insertId}');

    final userId = result.insertId;

    print('[User Route] Returning success response');
    return Response(
      statusCode: 201,
      headers: {
        'Content-Type': 'application/json',
        ..._corsHeaders(),
      },
      body: jsonEncode({
        'success': true,
        'data': {
          'id': userId,
          'email': email,
          'lastName': lastName,
        }
      }),
    );
  } catch (e) {
    if (e is FormatException) {
      return Response(
        statusCode: 400,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'Invalid JSON format in request body'}),
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

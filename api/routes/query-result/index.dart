import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:mysql_client_plus/mysql_client_plus.dart';
import 'package:shared/shared.dart';

import '../../lib/database_service.dart';

/// POST /query-result
/// Creates a new query result (learning plan) in the database
Future<Response> onRequest(RequestContext context) async {
  
  late final ResultSet result;

  // Handle CORS preflight requests
  if (context.request.method == HttpMethod.options) {
    return Response(
      statusCode: 200,
      headers: _corsHeaders(),
    );
  }
  
  // Only allow POST requests
  if (context.request.method != HttpMethod.post) {
    return Response(
      statusCode: 405,
      headers: _corsHeaders(),
      body: jsonEncode({'error': 'Method not allowed'}),
    );
  }

  try {
    final body = await context.request.body();
    final Map<String, dynamic> requestData = jsonDecode(body) as Map<String, dynamic>;
    
    print('*** Query Results: Received request data: $requestData');
    // Validate required fields
    final queryResultNickname = requestData['queryResultNickname'] as String?;
    final queryProfileId = requestData['queryProfileId'] as int?;
    final resultText = requestData['resultText'] as String?;
    
    if (queryResultNickname == null || queryResultNickname.trim().isEmpty) {
      return Response(
        statusCode: 400,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'Query result nickname is required'}),
      );
    }
    
    if (queryProfileId == null) {
      return Response(
        statusCode: 400,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'Query Profile ID is required'}),
      );
    }
    
    if (resultText == null || resultText.trim().isEmpty) {
      return Response(
        statusCode: 400,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'Result text is required'}),
      );
    }

    // Ensure database is initialized
    final db = DatabaseService();
    await db.initialize();

    try{
      print('Inserting query result in database');
      // Insert query result in database
      result = await db.query(
        '''INSERT INTO query_result 
        (query_result_nickname, query_id, result_text) 
        VALUES (?, ?, ?)''',
        [queryResultNickname, queryProfileId, resultText],
      );

      print('Query result inserted successfully');

    } catch (e) {
      print('Error initializing database (Query Result): $e');
      return Response(
        statusCode: 500,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'Failed to initialize database (Query Result): ${e.toString()}'}),
      );
    }
    
    print('Fetching insert ID for query result');

    final resultId = result.length;
    print('Insert ID for query result: $resultId');
    
    return Response(
      statusCode: 201,
      headers: {
        'Content-Type': 'application/json',
        ..._corsHeaders(),
      },
      body: jsonEncode({
        'success': true,
        'data': {
          'id': resultId,
          'queryProfileId': queryProfileId,
          'nickname': queryResultNickname,
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
      body: jsonEncode({'error': 'Internal server error (Query Result): ${e.toString()}'}),
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

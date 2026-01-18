import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:shared/shared.dart';
import '../../lib/database_service.dart';

/// POST /query-result
/// Creates a new query result (learning plan) in the database
Future<Response> onRequest(RequestContext context) async {
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

    // Insert or update query result in database
    final db = DatabaseService();
    final result = await db.connection.query(
      '''INSERT INTO query_result 
        (query_result_nickname, query_id, result_text, result_date) 
        VALUES (?, ?, ?, NOW())
        ON DUPLICATE KEY UPDATE 
        result_text = VALUES(result_text),
        result_date = NOW(),
        id = LAST_INSERT_ID(id)''',
      [queryResultNickname, queryProfileId, resultText],
    );

    final resultId = result.insertId;
    
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

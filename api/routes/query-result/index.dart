import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:shared/shared.dart';
import '../../lib/database_service.dart';

/// POST /query-result/create
/// Creates a new query result (learning plan) in the database
Future<Response> onRequest(RequestContext context) async {
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
    final queryId = requestData['queryId'] as int?;
    final resultText = requestData['resultText'] as String?;
    
    if (queryResultNickname == null || queryResultNickname.trim().isEmpty) {
      return Response(
        statusCode: 400,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'Query result nickname is required'}),
      );
    }
    
    if (queryId == null) {
      return Response(
        statusCode: 400,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'Query ID is required'}),
      );
    }
    
    if (resultText == null || resultText.trim().isEmpty) {
      return Response(
        statusCode: 400,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'Result text is required'}),
      );
    }

    // Insert query result into database
    final db = DatabaseService();
    final result = await db.connection.query(
      '''INSERT INTO query_result 
         (query_result_nickname, query_id, result_text, result_date) 
         VALUES (?, ?, ?, NOW())''',
      [queryResultNickname, queryId, resultText],
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
          'queryId': queryId,
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

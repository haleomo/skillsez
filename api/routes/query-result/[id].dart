import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:shared/shared.dart';
import '../../lib/database_service.dart';

/// GET /query-result/[id]
/// Retrieves a query result by ID
Future<Response> onRequest(RequestContext context, String id) async {
  if (context.request.method != HttpMethod.get) {
    return Response(
      statusCode: 405,
      headers: _corsHeaders(),
      body: jsonEncode({'error': 'Method not allowed'}),
    );
  }

  try {
    final resultId = int.parse(id);
    
    final db = DatabaseService();
    final results = await db.connection.query(
      '''SELECT id, query_result_nickname, query_id, result_text, result_date 
         FROM query_result WHERE id = ?''',
      [resultId],
    );

    if (results.isEmpty) {
      return Response(
        statusCode: 404,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'Query result not found'}),
      );
    }

    final row = results.first;
    final queryResult = QueryResult(
      id: row['id'] as int,
      queryResultNickname: row['query_result_nickname'] as String,
      queryId: row['query_id'] as int,
      resultText: row['result_text'] as String,
      resultDate: row['result_date'] as DateTime?,
    );

    return Response(
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        ..._corsHeaders(),
      },
      body: jsonEncode({
        'success': true,
        'data': queryResult.toJson()
      }),
    );
  } catch (e) {
    if (e is FormatException) {
      return Response(
        statusCode: 400,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'Invalid query result ID format'}),
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

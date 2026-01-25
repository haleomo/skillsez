import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:shared/shared.dart';
import '../../lib/database_service.dart';

/// GET /views/user-query-result
/// Retrieves all user-query-result records from the user_query_result_view
Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.get) {
    return Response(
      statusCode: 405,
      headers: _corsHeaders(),
      body: jsonEncode({'error': 'Method not allowed'}),
    );
  }

  try {
    final db = DatabaseService();
    final results = await db.query(
      '''
        SELECT email, last_name, result_id, query_id, query_result_nickname, result_text, result_date 
        FROM user_query_result_view ORDER BY result_date DESC''',
    );
    
    final userQueryResults = results.rows.map((row) {
      return UserQueryResultView(
        email: row.colByName('email')?.toString() ?? '',
        lastName: row.colByName('last_name')?.toString() ?? '',
        resultId: int.parse(row.colByName('result_id')?.toString() ?? '0'),
        queryId: int.parse(row.colByName('query_id')?.toString() ?? '0'),
        queryResultNickname: row.colByName('query_result_nickname')?.toString() ?? '',
        resultText: row.colByName('result_text')?.toString() ?? '',
        resultDate: DateTime.tryParse(row.colByName('result_date')?.toString() ?? ''),
      );
    }).toList();

    return Response(
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        ..._corsHeaders(),
      },
      body: jsonEncode({
        'success': true,
        'data': {
          'count': userQueryResults.length,
          'userQueryResults': userQueryResults.map((uqr) => uqr.toJson()).toList() 
        }
      }),
    );
  } catch (e) {
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

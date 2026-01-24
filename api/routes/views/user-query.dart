import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:shared/shared.dart';
import '../../lib/database_service.dart';

/// GET /views/user-query
/// Retrieves all user-query records from the user_query_view
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
        SELECT user_id, email, last_name, created_at, query_id, query_date, 
          query_text, source_discipline, subjecteducation_level, 
          subject_discipline, topic, goal, role 
        FROM user_query_view ORDER BY query_date DESC''',
    );
    
    final userQueries = results.rows.map((row) {
      return UserQueryView(
        userId: int.parse((row.colByName('user_id'))?.toString() ?? '0'),
        email: (row.colByName('email'))?.toString() ?? '',
        lastName: (row.colByName('last_name'))?.toString() ?? '',
        createdAt: DateTime.tryParse((row.colByName('created_at'))?.toString() ?? ''),
        queryId: int.parse((row.colByName('query_id'))?.toString() ?? '0'),
        queryDate: DateTime.tryParse((row.colByName('query_date'))?.toString() ?? ''),
        queryText: (row.colByName('query_text'))?.toString() ?? '',
        sourceDiscipline: (row.colByName('source_discipline'))?.toString() ?? '',
        subjectEducationLevel: (row.colByName('subjecteducation_level'))?.toString() ?? '',
        subjectDiscipline: (row.colByName('subject_discipline'))?.toString() ?? '',
        topic: (row.colByName('topic'))?.toString() ?? '',
        goal: (row.colByName('goal'))?.toString() ?? '',
        role: (row.colByName('role'))?.toString() ?? '',
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
          'count': userQueries.length,
          'userQueries': userQueries.map((uq) => uq.toJson()).toList()
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

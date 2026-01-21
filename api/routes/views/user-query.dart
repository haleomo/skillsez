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
      '''SELECT user_id, email, last_name, created_at, query_id, query_date, 
               query_text, source_discipline, subjecteducation_level, 
               subject_discipline, topic, goal, role 
        FROM user_query_view ORDER BY query_date DESC''',
    );

    final userQueries = results.map((row) {
      return UserQueryView(
        userId: row['user_id'] as int,
        email: row['email'] as String,
        lastName: row['last_name'] as String,
        createdAt: row['created_at'] as DateTime?,
        queryId: row['query_id'] as int,
        queryDate: row['query_date'] as DateTime?,
        queryText: row['query_text'] as String,
        sourceDiscipline: row['source_discipline'] as String,
        subjectEducationLevel: row['subjecteducation_level'] as String,
        subjectDiscipline: row['subject_discipline'] as String,
        topic: row['topic'] as String,
        goal: row['goal'] as String,
        role: row['role'] as String,
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

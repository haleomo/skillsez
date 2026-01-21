import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:shared/shared.dart';
import '../../lib/database_service.dart';

/// GET /query-profile/[id]
/// Retrieves a query profile by ID
Future<Response> onRequest(RequestContext context, String id) async {
  if (context.request.method != HttpMethod.get) {
    return Response(
      statusCode: 405,
      headers: _corsHeaders(),
      body: jsonEncode({'error': 'Method not allowed'}),
    );
  }

  try {
    final queryId = int.parse(id);
    
    final db = DatabaseService();
    final results = await db.query(
      '''SELECT id, user_id, query_date, query_text, source_discipline, 
              subjecteducation_level, subject_discipline, topic, goal, role 
        FROM query_profile WHERE id = ?''',
      [queryId],
    );

    if (results.isEmpty) {
      return Response(
        statusCode: 404,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'Query profile not found'}),
      );
    }

    final row = results.first;
    final queryProfile = QueryProfileRecord(
      id: row['id'] as int,
      userId: row['user_id'] as int,
      queryDate: row['query_date'] as DateTime?,
      queryText: row['query_text'] as String,
      sourceDiscipline: row['source_discipline'] as String,
      subjectEducationLevel: row['subjecteducation_level'] as String,
      subjectDiscipline: row['subject_discipline'] as String,
      topic: row['topic'] as String,
      goal: row['goal'] as String,
      role: row['role'] as String,
    );

    return Response(
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        ..._corsHeaders(),
      },
      body: jsonEncode({
        'success': true,
        'data': queryProfile.toJson()
      }),
    );
  } catch (e) {
    if (e is FormatException) {
      return Response(
        statusCode: 400,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'Invalid query profile ID format'}),
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

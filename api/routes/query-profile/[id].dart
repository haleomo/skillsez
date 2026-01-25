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
      '''
        SELECT id, user_id, query_date, query_text, source_discipline, 
              subject_education_level, subject_work_experience, subject_discipline, 
              topic, goal, role 
        FROM query_profile WHERE id = ?''',
      [queryId],
    );

    if (results.rows.isEmpty) {
      return Response(
        statusCode: 404,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'Query profile not found'}),
      );
    }
    
    final row = results.rows.first;
    final queryProfile = QueryProfileRecord(
      id: int.parse(row.colByName('id')?.toString() ?? '0'),
      userId: int.parse(row.colByName('user_id')?.toString() ?? '0'),
      queryDate: DateTime.tryParse(row.colByName('query_date')?.toString() ?? ''),
      queryText: row.colByName('query_text')?.toString() ?? '',
      sourceDiscipline: row.colByName('source_discipline')?.toString() ?? '',
      subjectEducationLevel: row.colByName('subject_education_level')?.toString() ?? '',
      subjectWorkExperience: row.colByName('subject_work_experience')?.toString() ?? '',
      subjectDiscipline: row.colByName('subject_discipline')?.toString() ?? '',
      topic: row.colByName('topic')?.toString() ?? '',
      goal: row.colByName('goal')?.toString() ?? '',
      role: row.colByName('role')?.toString() ?? '',
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

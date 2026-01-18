import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:shared/shared.dart';
import '../../lib/database_service.dart';

/// POST /query-profile
/// Creates a new query profile in the database
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
    final userId = requestData['userId'] as int?;
    final queryText = requestData['queryText'] as String?;
    final sourceDiscipline = requestData['sourceDiscipline'] as String?;
    final subjectEducationLevel = requestData['subjectEducationLevel'] as String?;
    final subjectDiscipline = requestData['subjectDiscipline'] as String?;
    final topic = requestData['topic'] as String?;
    final goal = requestData['goal'] as String?;
    final role = requestData['role'] as String?;
    
    if (userId == null) {
      return Response(
        statusCode: 400,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'User ID is required'}),
      );
    }
    
    if (topic == null || topic.trim().isEmpty) {
      return Response(
        statusCode: 400,
        headers: _corsHeaders(),
        body: jsonEncode({'error': 'Topic is required'}),
      );
    }

    // Insert or update query profile in database
    final db = DatabaseService();
    final result = await db.connection.query(
      '''INSERT INTO query_profile 
         (user_id, query_date, query_text, source_discipline, subjecteducation_level, 
          subject_discipline, topic, goal, role) 
         VALUES (?, NOW(), ?, ?, ?, ?, ?, ?, ?)
         ON DUPLICATE KEY UPDATE 
         query_date = NOW(),
         query_text = VALUES(query_text),
         subjecteducation_level = VALUES(subjecteducation_level),
         id = LAST_INSERT_ID(id)''',
      [userId, queryText ?? '', sourceDiscipline ?? '', subjectEducationLevel ?? '', 
       subjectDiscipline ?? '', topic, goal ?? '', role ?? ''],
    );

    final queryId = result.insertId;

    return Response(
      statusCode: 201,
      headers: {
        'Content-Type': 'application/json',
        ..._corsHeaders(),
      },
      body: jsonEncode({
        'success': true,
        'data': {
          'id': queryId,
          'userId': userId,
          'topic': topic,
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

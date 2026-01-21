import 'dart:convert';
import 'package:api/database_service.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mysql_client_plus/mysql_client_plus.dart';

/// POST /query-profile
/// Creates a new query profile in the database
Future<Response> onRequest(RequestContext context) async {
  int? userId;
  String? queryText; // Optional
  String? sourceDiscipline; 
  String? subjectEducationLevel;
  String? subjectDiscipline;
  String? subjectWorkExperience;
  String? topic;
  String? goal;
  String? role;

  late final Future<ResultSet> result;


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
    
    print('*** Query Profile Request data: $requestData ');
    
    try {
      // Validate required fields
      userId = requestData['userId'] as int?;
      queryText = requestData['queryText'] as String? ?? ''; // Optional
      sourceDiscipline = requestData['sourceExpertDiscipline'] as String?; 
      subjectEducationLevel = requestData['subjectEducationLevel'] as String?;
      subjectDiscipline = requestData['subjectDiscipline'] as String?;
      subjectWorkExperience = requestData['subjectWorkExperience'] as String?;
      topic = requestData['topic'] as String?;
      goal = requestData['goal'] as String?;
      role = requestData['role'] as String?;
    } catch (e) {
      print('Error parsing request data (Query Profile): $e');
      throw Exception('Error parsing request data: $e');
    }
    
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

    // Ensure database is initialized
    final db = DatabaseService();
    await db.initialize();
    
    // Insert query profile in database
    try {
        result = db.query(
          '''
          INSERT INTO query_profile 
          (user_id, query_text, source_discipline, subject_education_level, 
          subject_work_experience, subject_discipline, topic, goal, role) 
          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)''',
          [userId, queryText ?? '', sourceDiscipline ?? '', subjectEducationLevel ?? '', 
          subjectWorkExperience ?? '', subjectDiscipline ?? '', topic, goal ?? '', role ?? ''],
        );
      } catch (e) { 
        print('Error inserting/updating query profile: $e');
        return Response(
          statusCode: 500,
          headers: _corsHeaders(),
          body: jsonEncode({'error': 'Failed to insert/update (Query Profile): ${e.toString()}'}),
        );
      }

    print('Inserted/updated query profile');
    final queryId = (await result).length;
    print('Query Profile ID: $queryId');

    return Response(
      statusCode: 201,
      headers: {
        'Content-Type': 'application/json',
        ..._corsHeaders(),
      },
      body: jsonEncode({
        'success': true,
        'data': {
          'id': 0,
          'userId': userId,
          'topic': topic,
        }
      }),
    );
  } catch (e) {
    print('Error processing request (Query Profile): $e');
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
      body: jsonEncode({'error': 'Internal server error (Query Profile): ${e.toString()}'}),
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

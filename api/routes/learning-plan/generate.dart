import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import 'package:shared/shared.dart';
import '../../services/learning_plan_service.dart';

/// POST /learning-plan/generate
/// 
/// Generates a learning plan using Google Gemini AI based on the provided QueryProfile
Future<Response> onRequest(RequestContext context) async {
  // Only allow POST requests
  if (context.request.method != HttpMethod.post) {
    return Response(
      statusCode: 405,
      body: jsonEncode({'error': 'Method not allowed'}),
    );
  }

  try {
    // Parse the request body
    final body = await context.request.body();
    final Map<String, dynamic> requestData = jsonDecode(body) as Map<String, dynamic>;
    
    // Create QueryProfile from the request data
    final queryProfile = QueryProfile.fromJson(requestData);
    
    // Validate required fields (additional validation can be added here)
    if (queryProfile.topic.trim().isEmpty) {
      return Response(
        statusCode: 400,
        body: jsonEncode({'error': 'Topic is required'}),
      );
    }
    
    // Generate learning plan using the service
    final learningPlanService = LearningPlanService();
    final learningPlan = await learningPlanService.generateLearningPlan(queryProfile);
    
    return Response(
      statusCode: 200,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'success': true,
        'data': {
          'learning_plan': learningPlan,
          'query_profile': queryProfile.toJson(),
        }
      }),
    );
    
  } catch (e) {
    // Handle various error types
    if (e is FormatException) {
      return Response(
        statusCode: 400,
        body: jsonEncode({'error': 'Invalid JSON format in request body'}),
      );
    }
    
    return Response(
      statusCode: 500,
      body: jsonEncode({'error': 'Internal server error: ${e.toString()}'}),
    );
  }
}
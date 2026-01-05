import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared/shared.dart';

/// Service for generating learning plans using Google Gemini AI
class LearningPlanService {
  static const String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro-latest:generateContent';
  
  /// Generates a comprehensive learning plan based on the provided QueryProfile
  Future<Map<String, dynamic>> generateLearningPlan(QueryProfile queryProfile) 
    async {
    // Try to get API key from environment variable (set by server.dart or system)
    final apiKey = Platform.environment['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('GEMINI_API_KEY environment variable is not set');
    }

    // Construct the prompt based on the QueryProfile
    final prompt = _buildPrompt(queryProfile);
    
    // Prepare the request payload for Gemini API
    final requestBody = {
      'contents': [
        {
          'parts': [
            {
              'text': prompt
            }
          ]
        }
      ],
      'generationConfig': {
        'temperature': 0.7,
        'topK': 40,
        'topP': 0.95,
        'maxOutputTokens': 8192,
      }
    };

    try {
      // Make the API call to Google Gemini
      final response = await http.post(
        Uri.parse('$_baseUrl?key=$apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final content = responseData['candidates'][0]['content']['parts'][0]['text'] as String;
        
        // Parse the generated content into a structured format
        return _parseGeneratedContent(content, queryProfile);
      } else {
        // Include more details about the error
        final errorBody = response.body;
        throw Exception('Gemini API error: ${response.statusCode} - $errorBody');
      }
    } catch (e) {
      throw Exception('Failed to generate learning plan: $e');
    }
  }

  /// Builds a detailed prompt for the Gemini AI based on the QueryProfile
  String _buildPrompt(QueryProfile queryProfile) {
    return '''
You are an expert learning plan designer with expertise in ${queryProfile.sourceExpertDiscipline}. 

Please create a comprehensive, personalized learning plan for the following profile:

**Learner Profile:**
- Education Level: ${queryProfile.subjectEducationLevel}
- Background Discipline: ${queryProfile.subjectDiscipline}
- Work Experience: ${queryProfile.subjectWorkExperience}
- Target Topic: ${queryProfile.topic}
- Learning Goal: ${queryProfile.goal}
- Desired Role: ${queryProfile.role}

**Requirements:**
Create a structured learning plan that includes:

1. **Learning Objectives** - Clear, measurable goals
2. **Prerequisite Knowledge** - What they should know before starting
3. **Learning Path** - Step-by-step progression with phases/milestones
4. **Resources** - Books, courses, tutorials, tools, and platforms
5. **Timeline** - Realistic timeframes for each phase
6. **Assessment Methods** - How to evaluate progress
7. **Key Skills to Develop** - Technical and soft skills
8. **Common Challenges** - Potential obstacles and how to overcome them
9. **Success Metrics** - How to measure completion and competency

**Additional Context:**
- Consider the learner's existing background in ${queryProfile.subjectDiscipline}
- Tailor difficulty progression based on ${queryProfile.subjectEducationLevel} education level
- Focus on practical applications relevant to ${queryProfile.goal}
- Include role-specific skills needed for ${queryProfile.role}

Please provide a detailed, actionable plan that bridges the gap between their current state and desired role. Format the response as a well-structured, comprehensive guide.
''';
  }

  /// Parses the generated content from Gemini into a structured format
  Map<String, dynamic> _parseGeneratedContent(String content, QueryProfile queryProfile) {
    // For now, return the raw content along with metadata
    // This can be enhanced to parse the content into structured sections
    return {
      'plan_id': DateTime.now().millisecondsSinceEpoch.toString(),
      'generated_at': DateTime.now().toIso8601String(),
      'topic': queryProfile.topic,
      'target_role': queryProfile.role,
      'learning_goal': queryProfile.goal,
      'content': content,
      'status': 'generated',
      'metadata': {
        'model': 'gemini-pro-latest',
        'source_expert_discipline': queryProfile.sourceExpertDiscipline,
        'subject_education_level': queryProfile.subjectEducationLevel,
        'subject_discipline': queryProfile.subjectDiscipline,
      }
    };
  }
}
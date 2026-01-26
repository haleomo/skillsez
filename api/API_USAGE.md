# API Usage Examples

## Learning Plan Generation Endpoint

### POST `/learning-plan/generate`

Generate a personalized learning plan using Google Gemini AI.

#### Request Body

```json
{
  "sourceExpertDiscipline": "Software Engineering",
  "subjectEducationLevel": "Bachelor's Degree",
  "subjectDiscipline": "Computer Science",
  "subjectWorkExperience": "2 years web development",
  "subjectExperienceTime": "2 years",
  "topic": "Flutter Mobile Development",
  "goal": "work",
  "role": "mobile developer"
}
```

#### Response

**Success (200)**:
```json
{
  "success": true,
  "data": {
    "learning_plan": {
      "plan_id": "1703456789123",
      "generated_at": "2024-12-24T15:30:45.123Z",
      "topic": "Flutter Mobile Development",
      "target_role": "mobile developer",
      "learning_goal": "work",
      "content": "# Comprehensive Flutter Mobile Development Learning Plan\n\n## Learning Objectives...",
      "status": "generated",
      "metadata": {
        "model": "gemini-1.5-flash-latest",
        "source_expert_discipline": "Software Engineering",
        "subject_education_level": "Bachelor's Degree",
        "subject_discipline": "Computer Science"
      }
    },
    "query_profile": {
      "sourceExpertDiscipline": "Software Engineering",
      "subjectEducationLevel": "Bachelor's Degree",
      "subjectDiscipline": "Computer Science",
      "subjectWorkExperience": "2 years web development",
      "subjectExperienceTime": "2 years",
      "topic": "Flutter Mobile Development",
      "goal": "work",
      "role": "mobile developer"
    }
  }
}
```

**Error (400)**:
```json
{
  "error": "Topic is required"
}
```

**Error (500)**:
```json
{
  "error": "Internal server error: GEMINI_API_KEY environment variable is not set"
}
```

### Example Usage

#### cURL
```bash
curl -X POST http://localhost:8080/learning-plan/generate \
  -H "Content-Type: application/json" \
  -d '{
    "sourceExpertDiscipline": "Software Engineering",
    "subjectEducationLevel": "Bachelor'\''s Degree",
    "subjectDiscipline": "Computer Science", 
    "subjectWorkExperience": "2 years web development",
    "subjectExperienceTime": "2 years",
    "topic": "Flutter Mobile Development",
    "goal": "work",
    "role": "mobile developer"
  }'
```

#### Dart HTTP Client
```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared/shared.dart';

Future<void> generateLearningPlan() async {
  final queryProfile = QueryProfile(
    sourceExpertDiscipline: 'Software Engineering',
    subjectEducationLevel: 'Bachelor\'s Degree',
    subjectDiscipline: 'Computer Science',
    subjectWorkExperience: '2 years web development',
    subjectExperienceTime: '2 years',
    topic: 'Flutter Mobile Development',
    goal: 'work',
    role: 'mobile developer',
  );

  final response = await http.post(
    Uri.parse('http://localhost:8080/learning-plan/generate'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(queryProfile.toJson()),
  );

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    print('Learning plan generated: ${result['data']['learning_plan']['plan_id']}');
  } else {
    print('Error: ${response.body}');
  }
}
```

## Environment Setup

1. Create `.env` file in the API root directory:
```bash
GEMINI_API_KEY=your_actual_gemini_api_key_here
```

2. Start the server:
```bash
./start-frog.sh
```
Or with hot reload during development:
```bash
dart_frog dev
```

The API will be available at `http://localhost:8080`.

## User Registration & Authentication

Users must be registered before generating learning plans.

### POST `/user`
Register a new user or update existing user (upsert by email).

#### Request Body
```json
{
  "email": "user@example.com",
  "lastName": "Smith"
}
```

#### Response (200)
```json
{
  "success": true,
  "data": {
    "id": 1,
    "email": "user@example.com",
    "lastName": "Smith",
    "createdAt": "2024-01-15T10:00:00.000Z"
  }
}
```

### GET `/user/[id]`
Retrieve user details by ID.

#### Response (200)
```json
{
  "success": true,
  "data": {
    "id": 1,
    "email": "user@example.com",
    "lastName": "Smith",
    "createdAt": "2024-01-15T10:00:00.000Z"
  }
}
```

### PUT `/user/[id]`
Update user email and/or last name.

#### Request Body
```json
{
  "email": "newemail@example.com",
  "lastName": "NewLastName"
}
```

#### Response (200)
```json
{
  "success": true,
  "data": {
    "id": 1,
    "email": "newemail@example.com",
    "lastName": "NewLastName",
    "createdAt": "2024-01-15T10:00:00.000Z"
  }
}
```
import 'package:shared/shared.dart';

void main() {
  // Example usage of QueryProfile
  final queryProfile = QueryProfile(
    sourceExpertDiscipline: 'Software Engineering',
    subjectEducationLevel: 'Bachelor\'s Degree',
    subjectDiscipline: 'Computer Science',
    subjectWorkExperience: '2 years',
    subjectExperienceTime: '2 years in web development',
    topic: 'Flutter Mobile Development',
    goal: 'work',
    role: 'mobile developer',
  );

  print('Query Profile created:');
  print('Topic: ${queryProfile.topic}');
  print('Goal: ${queryProfile.goal}');
  print('Target Role: ${queryProfile.role}');
  print('Subject Education: ${queryProfile.subjectEducationLevel}');
  
  // Convert to/from JSON
  final json = queryProfile.toJson();
  print('\nJSON representation:');
  print(json);
  
  final fromJson = QueryProfile.fromJson(json);
  print('\nRecreated from JSON:');
  print('Same instance: ${queryProfile == fromJson}');
}
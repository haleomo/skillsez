import 'package:freezed_annotation/freezed_annotation.dart';

part 'query_profile.freezed.dart';
part 'query_profile.g.dart';

/// Represents a query profile containing data used in AI calls for skill planning.
/// 
/// This class holds comprehensive information about a query including the source
/// expert's background, subject details, learning goals, and target role.
@freezed
class QueryProfile with _$QueryProfile {
  const factory QueryProfile({
    /// The discipline or field of expertise of the source expert
    required String sourceExpertDiscipline,
    
    /// The education level of the subject (e.g., "High School", "Bachelor's", "Master's", "PhD")
    required String subjectEducationLevel,
    
    /// The primary discipline or field of study for the subject
    required String subjectDiscipline,
    
    /// The subject's relevant work experience in years or description
    required String subjectWorkExperience,
    
    /// The amount of time the subject has been in their experience area
    required String subjectExperienceTime,
    
    /// The specific topic or skill to be learned
    required String topic,
    
    /// The goal for learning this skill (e.g., "work", "general knowledge", "hire")
    required String goal,
    
    /// The target role the subject wants to achieve (e.g., "planner", "engineer", "coder")
    required String role,
  }) = _QueryProfile;

  /// Creates a QueryProfile from JSON
  factory QueryProfile.fromJson(Map<String, dynamic> json) =>
      _$QueryProfileFromJson(json);
}
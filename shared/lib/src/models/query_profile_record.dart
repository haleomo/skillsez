import 'package:freezed_annotation/freezed_annotation.dart';

part 'query_profile_record.freezed.dart';
part 'query_profile_record.g.dart';

/// Represents a query profile record stored in the database
@freezed
abstract class QueryProfileRecord with _$QueryProfileRecord {
  const factory QueryProfileRecord({
    /// Unique identifier for the record
    int? id,
    
    /// Reference to the user who made the query
    required int userId,
    
    /// Date the query was made
    DateTime? queryDate,
    
    /// Original query text
    required String queryText,
    
    /// The discipline or field of expertise of the source expert
    required String sourceDiscipline,
    
    /// The education level of the subject
    required String subjectEducationLevel,
    
    /// The primary discipline or field of study for the subject
    required String subjectDiscipline,
    
    /// The subject's relevant work experience
    required String subjectWorkExperience,
    
    /// The specific topic or skill to be learned
    required String topic,
    
    /// The goal for learning this skill
    required String goal,
    
    /// The target role the subject wants to achieve
    required String role,
  }) = _QueryProfileRecord;

  /// Creates a QueryProfileRecord from JSON
  factory QueryProfileRecord.fromJson(Map<String, dynamic> json) =>
      _$QueryProfileRecordFromJson(json);
}

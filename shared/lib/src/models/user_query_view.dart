import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_query_view.freezed.dart';
part 'user_query_view.g.dart';

/// Represents a row from the user_query_view
@freezed
abstract class UserQueryView with _$UserQueryView {
  const factory UserQueryView({
    /// User ID
    required int userId,
    
    /// User's email
    required String email,
    
    /// User's last name
    required String lastName,
    
    /// User's creation date
    DateTime? createdAt,
    
    /// Query ID
    required int queryId,
    
    /// Date the query was made
    DateTime? queryDate,
    
    /// Original query text
    required String queryText,
    
    /// Source discipline
    required String sourceDiscipline,
    
    /// Subject education level
    required String subjectEducationLevel,
    
    /// Subject discipline
    required String subjectDiscipline,
    
    /// Subject work experience
    required String subjectWorkExperience,
    
    /// Topic
    required String topic,
    
    /// Goal
    required String goal,
    
    /// Role
    required String role,
  }) = _UserQueryView;

  /// Creates a UserQueryView from JSON
  factory UserQueryView.fromJson(Map<String, dynamic> json) =>
      _$UserQueryViewFromJson(json);
}

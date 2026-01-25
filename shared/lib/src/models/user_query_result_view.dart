import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_query_result_view.freezed.dart';
part 'user_query_result_view.g.dart';

/// Represents a row from the user_query_result_view
@freezed
abstract class UserQueryResultView with _$UserQueryResultView {
  const factory UserQueryResultView({
    /// User's email
    required String email,
    
    /// User's last name
    required String lastName,
    
    /// Associated query ID
    required int queryId,
    
    /// Query result nickname
    required String queryResultNickname,
    
    /// Date the result was saved
    DateTime? resultDate,
    
    /// Query result ID
    required int resultId,
    
    /// Result text/content
    required String resultText,
  }) = _UserQueryResultView;

  /// Creates a UserQueryResultView from JSON
  factory UserQueryResultView.fromJson(Map<String, dynamic> json) =>
      _$UserQueryResultViewFromJson(json);
}

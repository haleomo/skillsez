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
    
    /// Query result nickname
    required String queryResultNickname,
    
    /// Result text/content
    required String resultText,
    
    /// Date the result was saved
    DateTime? resultDate,
  }) = _UserQueryResultView;

  /// Creates a UserQueryResultView from JSON
  factory UserQueryResultView.fromJson(Map<String, dynamic> json) =>
      _$UserQueryResultViewFromJson(json);
}

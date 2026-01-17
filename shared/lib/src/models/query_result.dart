import 'package:freezed_annotation/freezed_annotation.dart';

part 'query_result.freezed.dart';
part 'query_result.g.dart';

/// Represents a query result (learning plan) saved in the database
@freezed
abstract class QueryResult with _$QueryResult {
  const factory QueryResult({
    /// Unique identifier for the query result
    int? id,
    
    /// User-provided nickname for this plan
    required String queryResultNickname,
    
    /// Reference to the query profile that generated this result
    required int queryId,
    
    /// The actual result content (learning plan)
    required String resultText,
    
    /// Date the result was saved
    DateTime? resultDate,
  }) = _QueryResult;

  /// Creates a QueryResult from JSON
  factory QueryResult.fromJson(Map<String, dynamic> json) =>
      _$QueryResultFromJson(json);
}

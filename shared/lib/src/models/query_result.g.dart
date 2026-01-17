// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QueryResult _$QueryResultFromJson(Map<String, dynamic> json) => _QueryResult(
  id: (json['id'] as num?)?.toInt(),
  queryResultNickname: json['queryResultNickname'] as String,
  queryId: (json['queryId'] as num).toInt(),
  resultText: json['resultText'] as String,
  resultDate: json['resultDate'] == null
      ? null
      : DateTime.parse(json['resultDate'] as String),
);

Map<String, dynamic> _$QueryResultToJson(_QueryResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'queryResultNickname': instance.queryResultNickname,
      'queryId': instance.queryId,
      'resultText': instance.resultText,
      'resultDate': instance.resultDate?.toIso8601String(),
    };

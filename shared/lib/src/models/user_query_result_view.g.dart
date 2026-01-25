// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_query_result_view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserQueryResultView _$UserQueryResultViewFromJson(Map<String, dynamic> json) =>
    _UserQueryResultView(
      email: json['email'] as String,
      lastName: json['lastName'] as String,
      queryId: (json['queryId'] as num).toInt(),
      queryResultNickname: json['queryResultNickname'] as String,
      resultDate: json['resultDate'] == null
          ? null
          : DateTime.parse(json['resultDate'] as String),
      resultId: (json['resultId'] as num).toInt(),
      resultText: json['resultText'] as String,
    );

Map<String, dynamic> _$UserQueryResultViewToJson(
  _UserQueryResultView instance,
) => <String, dynamic>{
  'email': instance.email,
  'lastName': instance.lastName,
  'queryId': instance.queryId,
  'queryResultNickname': instance.queryResultNickname,
  'resultDate': instance.resultDate?.toIso8601String(),
  'resultId': instance.resultId,
  'resultText': instance.resultText,
};

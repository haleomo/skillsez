// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_query_result_view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserQueryResultView _$UserQueryResultViewFromJson(Map<String, dynamic> json) =>
    _UserQueryResultView(
      email: json['email'] as String,
      lastName: json['lastName'] as String,
      queryResultNickname: json['queryResultNickname'] as String,
      resultText: json['resultText'] as String,
      resultDate: json['resultDate'] == null
          ? null
          : DateTime.parse(json['resultDate'] as String),
    );

Map<String, dynamic> _$UserQueryResultViewToJson(
  _UserQueryResultView instance,
) => <String, dynamic>{
  'email': instance.email,
  'lastName': instance.lastName,
  'queryResultNickname': instance.queryResultNickname,
  'resultText': instance.resultText,
  'resultDate': instance.resultDate?.toIso8601String(),
};

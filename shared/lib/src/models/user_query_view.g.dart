// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_query_view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserQueryView _$UserQueryViewFromJson(Map<String, dynamic> json) =>
    _UserQueryView(
      userId: (json['userId'] as num).toInt(),
      email: json['email'] as String,
      lastName: json['lastName'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      queryId: (json['queryId'] as num).toInt(),
      queryDate: json['queryDate'] == null
          ? null
          : DateTime.parse(json['queryDate'] as String),
      queryText: json['queryText'] as String,
      sourceDiscipline: json['sourceDiscipline'] as String,
      subjectEducationLevel: json['subjectEducationLevel'] as String,
      subjectDiscipline: json['subjectDiscipline'] as String,
      subjectWorkExperience: json['subjectWorkExperience'] as String,
      topic: json['topic'] as String,
      goal: json['goal'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$UserQueryViewToJson(_UserQueryView instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'lastName': instance.lastName,
      'createdAt': instance.createdAt?.toIso8601String(),
      'queryId': instance.queryId,
      'queryDate': instance.queryDate?.toIso8601String(),
      'queryText': instance.queryText,
      'sourceDiscipline': instance.sourceDiscipline,
      'subjectEducationLevel': instance.subjectEducationLevel,
      'subjectDiscipline': instance.subjectDiscipline,
      'subjectWorkExperience': instance.subjectWorkExperience,
      'topic': instance.topic,
      'goal': instance.goal,
      'role': instance.role,
    };

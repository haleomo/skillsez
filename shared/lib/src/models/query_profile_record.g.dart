// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_profile_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QueryProfileRecord _$QueryProfileRecordFromJson(Map<String, dynamic> json) =>
    _QueryProfileRecord(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num).toInt(),
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

Map<String, dynamic> _$QueryProfileRecordToJson(_QueryProfileRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
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

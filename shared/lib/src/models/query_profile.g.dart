// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QueryProfile _$QueryProfileFromJson(Map<String, dynamic> json) =>
    _QueryProfile(
      sourceExpertDiscipline: json['sourceExpertDiscipline'] as String,
      subjectEducationLevel: json['subjectEducationLevel'] as String? ?? '',
      subjectDiscipline: json['subjectDiscipline'] as String,
      subjectWorkExperience: json['subjectWorkExperience'] as String,
      topic: json['topic'] as String,
      goal: json['goal'] as String,
      role: json['role'] as String? ?? '',
    );

Map<String, dynamic> _$QueryProfileToJson(_QueryProfile instance) =>
    <String, dynamic>{
      'sourceExpertDiscipline': instance.sourceExpertDiscipline,
      'subjectEducationLevel': instance.subjectEducationLevel,
      'subjectDiscipline': instance.subjectDiscipline,
      'subjectWorkExperience': instance.subjectWorkExperience,
      'topic': instance.topic,
      'goal': instance.goal,
      'role': instance.role,
    };

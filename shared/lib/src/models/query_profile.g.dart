// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueryProfileImpl _$$QueryProfileImplFromJson(Map<String, dynamic> json) =>
    _$QueryProfileImpl(
      sourceExpertDiscipline: json['sourceExpertDiscipline'] as String,
      subjectEducationLevel: json['subjectEducationLevel'] as String,
      subjectDiscipline: json['subjectDiscipline'] as String,
      subjectWorkExperience: json['subjectWorkExperience'] as String,
      subjectExperienceTime: json['subjectExperienceTime'] as String,
      topic: json['topic'] as String,
      goal: json['goal'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$$QueryProfileImplToJson(_$QueryProfileImpl instance) =>
    <String, dynamic>{
      'sourceExpertDiscipline': instance.sourceExpertDiscipline,
      'subjectEducationLevel': instance.subjectEducationLevel,
      'subjectDiscipline': instance.subjectDiscipline,
      'subjectWorkExperience': instance.subjectWorkExperience,
      'subjectExperienceTime': instance.subjectExperienceTime,
      'topic': instance.topic,
      'goal': instance.goal,
      'role': instance.role,
    };

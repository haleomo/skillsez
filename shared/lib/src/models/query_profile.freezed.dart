// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QueryProfile {

/// The discipline or field of expertise of the source expert
 String get sourceExpertDiscipline;/// The education level of the subject (e.g., "High School", "Bachelor's", "Master's", "PhD")
 String get subjectEducationLevel;/// The primary discipline or field of study for the subject
 String get subjectDiscipline;/// The subject's relevant work experience in years or description
 String get subjectWorkExperience;/// The specific topic or skill to be learned
 String get topic;/// The goal for learning this skill (e.g., "career advancement", "general knowledge", "interview preparation")
 String get goal;/// The target role the subject wants to achieve (e.g., "planner", "engineer", "coder")
 String get role;
/// Create a copy of QueryProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueryProfileCopyWith<QueryProfile> get copyWith => _$QueryProfileCopyWithImpl<QueryProfile>(this as QueryProfile, _$identity);

  /// Serializes this QueryProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueryProfile&&(identical(other.sourceExpertDiscipline, sourceExpertDiscipline) || other.sourceExpertDiscipline == sourceExpertDiscipline)&&(identical(other.subjectEducationLevel, subjectEducationLevel) || other.subjectEducationLevel == subjectEducationLevel)&&(identical(other.subjectDiscipline, subjectDiscipline) || other.subjectDiscipline == subjectDiscipline)&&(identical(other.subjectWorkExperience, subjectWorkExperience) || other.subjectWorkExperience == subjectWorkExperience)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sourceExpertDiscipline,subjectEducationLevel,subjectDiscipline,subjectWorkExperience,topic,goal,role);

@override
String toString() {
  return 'QueryProfile(sourceExpertDiscipline: $sourceExpertDiscipline, subjectEducationLevel: $subjectEducationLevel, subjectDiscipline: $subjectDiscipline, subjectWorkExperience: $subjectWorkExperience, topic: $topic, goal: $goal, role: $role)';
}


}

/// @nodoc
abstract mixin class $QueryProfileCopyWith<$Res>  {
  factory $QueryProfileCopyWith(QueryProfile value, $Res Function(QueryProfile) _then) = _$QueryProfileCopyWithImpl;
@useResult
$Res call({
 String sourceExpertDiscipline, String subjectEducationLevel, String subjectDiscipline, String subjectWorkExperience, String topic, String goal, String role
});




}
/// @nodoc
class _$QueryProfileCopyWithImpl<$Res>
    implements $QueryProfileCopyWith<$Res> {
  _$QueryProfileCopyWithImpl(this._self, this._then);

  final QueryProfile _self;
  final $Res Function(QueryProfile) _then;

/// Create a copy of QueryProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sourceExpertDiscipline = null,Object? subjectEducationLevel = null,Object? subjectDiscipline = null,Object? subjectWorkExperience = null,Object? topic = null,Object? goal = null,Object? role = null,}) {
  return _then(_self.copyWith(
sourceExpertDiscipline: null == sourceExpertDiscipline ? _self.sourceExpertDiscipline : sourceExpertDiscipline // ignore: cast_nullable_to_non_nullable
as String,subjectEducationLevel: null == subjectEducationLevel ? _self.subjectEducationLevel : subjectEducationLevel // ignore: cast_nullable_to_non_nullable
as String,subjectDiscipline: null == subjectDiscipline ? _self.subjectDiscipline : subjectDiscipline // ignore: cast_nullable_to_non_nullable
as String,subjectWorkExperience: null == subjectWorkExperience ? _self.subjectWorkExperience : subjectWorkExperience // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QueryProfile].
extension QueryProfilePatterns on QueryProfile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueryProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueryProfile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueryProfile value)  $default,){
final _that = this;
switch (_that) {
case _QueryProfile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueryProfile value)?  $default,){
final _that = this;
switch (_that) {
case _QueryProfile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sourceExpertDiscipline,  String subjectEducationLevel,  String subjectDiscipline,  String subjectWorkExperience,  String topic,  String goal,  String role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueryProfile() when $default != null:
return $default(_that.sourceExpertDiscipline,_that.subjectEducationLevel,_that.subjectDiscipline,_that.subjectWorkExperience,_that.topic,_that.goal,_that.role);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sourceExpertDiscipline,  String subjectEducationLevel,  String subjectDiscipline,  String subjectWorkExperience,  String topic,  String goal,  String role)  $default,) {final _that = this;
switch (_that) {
case _QueryProfile():
return $default(_that.sourceExpertDiscipline,_that.subjectEducationLevel,_that.subjectDiscipline,_that.subjectWorkExperience,_that.topic,_that.goal,_that.role);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sourceExpertDiscipline,  String subjectEducationLevel,  String subjectDiscipline,  String subjectWorkExperience,  String topic,  String goal,  String role)?  $default,) {final _that = this;
switch (_that) {
case _QueryProfile() when $default != null:
return $default(_that.sourceExpertDiscipline,_that.subjectEducationLevel,_that.subjectDiscipline,_that.subjectWorkExperience,_that.topic,_that.goal,_that.role);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QueryProfile implements QueryProfile {
  const _QueryProfile({required this.sourceExpertDiscipline, this.subjectEducationLevel = '', required this.subjectDiscipline, required this.subjectWorkExperience, required this.topic, required this.goal, this.role = ''});
  factory _QueryProfile.fromJson(Map<String, dynamic> json) => _$QueryProfileFromJson(json);

/// The discipline or field of expertise of the source expert
@override final  String sourceExpertDiscipline;
/// The education level of the subject (e.g., "High School", "Bachelor's", "Master's", "PhD")
@override@JsonKey() final  String subjectEducationLevel;
/// The primary discipline or field of study for the subject
@override final  String subjectDiscipline;
/// The subject's relevant work experience in years or description
@override final  String subjectWorkExperience;
/// The specific topic or skill to be learned
@override final  String topic;
/// The goal for learning this skill (e.g., "career advancement", "general knowledge", "interview preparation")
@override final  String goal;
/// The target role the subject wants to achieve (e.g., "planner", "engineer", "coder")
@override@JsonKey() final  String role;

/// Create a copy of QueryProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueryProfileCopyWith<_QueryProfile> get copyWith => __$QueryProfileCopyWithImpl<_QueryProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QueryProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueryProfile&&(identical(other.sourceExpertDiscipline, sourceExpertDiscipline) || other.sourceExpertDiscipline == sourceExpertDiscipline)&&(identical(other.subjectEducationLevel, subjectEducationLevel) || other.subjectEducationLevel == subjectEducationLevel)&&(identical(other.subjectDiscipline, subjectDiscipline) || other.subjectDiscipline == subjectDiscipline)&&(identical(other.subjectWorkExperience, subjectWorkExperience) || other.subjectWorkExperience == subjectWorkExperience)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sourceExpertDiscipline,subjectEducationLevel,subjectDiscipline,subjectWorkExperience,topic,goal,role);

@override
String toString() {
  return 'QueryProfile(sourceExpertDiscipline: $sourceExpertDiscipline, subjectEducationLevel: $subjectEducationLevel, subjectDiscipline: $subjectDiscipline, subjectWorkExperience: $subjectWorkExperience, topic: $topic, goal: $goal, role: $role)';
}


}

/// @nodoc
abstract mixin class _$QueryProfileCopyWith<$Res> implements $QueryProfileCopyWith<$Res> {
  factory _$QueryProfileCopyWith(_QueryProfile value, $Res Function(_QueryProfile) _then) = __$QueryProfileCopyWithImpl;
@override @useResult
$Res call({
 String sourceExpertDiscipline, String subjectEducationLevel, String subjectDiscipline, String subjectWorkExperience, String topic, String goal, String role
});




}
/// @nodoc
class __$QueryProfileCopyWithImpl<$Res>
    implements _$QueryProfileCopyWith<$Res> {
  __$QueryProfileCopyWithImpl(this._self, this._then);

  final _QueryProfile _self;
  final $Res Function(_QueryProfile) _then;

/// Create a copy of QueryProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sourceExpertDiscipline = null,Object? subjectEducationLevel = null,Object? subjectDiscipline = null,Object? subjectWorkExperience = null,Object? topic = null,Object? goal = null,Object? role = null,}) {
  return _then(_QueryProfile(
sourceExpertDiscipline: null == sourceExpertDiscipline ? _self.sourceExpertDiscipline : sourceExpertDiscipline // ignore: cast_nullable_to_non_nullable
as String,subjectEducationLevel: null == subjectEducationLevel ? _self.subjectEducationLevel : subjectEducationLevel // ignore: cast_nullable_to_non_nullable
as String,subjectDiscipline: null == subjectDiscipline ? _self.subjectDiscipline : subjectDiscipline // ignore: cast_nullable_to_non_nullable
as String,subjectWorkExperience: null == subjectWorkExperience ? _self.subjectWorkExperience : subjectWorkExperience // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

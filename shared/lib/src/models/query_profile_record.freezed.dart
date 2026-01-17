// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query_profile_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QueryProfileRecord {

/// Unique identifier for the record
 int? get id;/// Reference to the user who made the query
 int get userId;/// Date the query was made
 DateTime? get queryDate;/// Original query text
 String get queryText;/// The discipline or field of expertise of the source expert
 String get sourceDiscipline;/// The education level of the subject
 String get subjectEducationLevel;/// The primary discipline or field of study for the subject
 String get subjectDiscipline;/// The specific topic or skill to be learned
 String get topic;/// The goal for learning this skill
 String get goal;/// The target role the subject wants to achieve
 String get role;
/// Create a copy of QueryProfileRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueryProfileRecordCopyWith<QueryProfileRecord> get copyWith => _$QueryProfileRecordCopyWithImpl<QueryProfileRecord>(this as QueryProfileRecord, _$identity);

  /// Serializes this QueryProfileRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueryProfileRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.queryDate, queryDate) || other.queryDate == queryDate)&&(identical(other.queryText, queryText) || other.queryText == queryText)&&(identical(other.sourceDiscipline, sourceDiscipline) || other.sourceDiscipline == sourceDiscipline)&&(identical(other.subjectEducationLevel, subjectEducationLevel) || other.subjectEducationLevel == subjectEducationLevel)&&(identical(other.subjectDiscipline, subjectDiscipline) || other.subjectDiscipline == subjectDiscipline)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,queryDate,queryText,sourceDiscipline,subjectEducationLevel,subjectDiscipline,topic,goal,role);

@override
String toString() {
  return 'QueryProfileRecord(id: $id, userId: $userId, queryDate: $queryDate, queryText: $queryText, sourceDiscipline: $sourceDiscipline, subjectEducationLevel: $subjectEducationLevel, subjectDiscipline: $subjectDiscipline, topic: $topic, goal: $goal, role: $role)';
}


}

/// @nodoc
abstract mixin class $QueryProfileRecordCopyWith<$Res>  {
  factory $QueryProfileRecordCopyWith(QueryProfileRecord value, $Res Function(QueryProfileRecord) _then) = _$QueryProfileRecordCopyWithImpl;
@useResult
$Res call({
 int? id, int userId, DateTime? queryDate, String queryText, String sourceDiscipline, String subjectEducationLevel, String subjectDiscipline, String topic, String goal, String role
});




}
/// @nodoc
class _$QueryProfileRecordCopyWithImpl<$Res>
    implements $QueryProfileRecordCopyWith<$Res> {
  _$QueryProfileRecordCopyWithImpl(this._self, this._then);

  final QueryProfileRecord _self;
  final $Res Function(QueryProfileRecord) _then;

/// Create a copy of QueryProfileRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = null,Object? queryDate = freezed,Object? queryText = null,Object? sourceDiscipline = null,Object? subjectEducationLevel = null,Object? subjectDiscipline = null,Object? topic = null,Object? goal = null,Object? role = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,queryDate: freezed == queryDate ? _self.queryDate : queryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,queryText: null == queryText ? _self.queryText : queryText // ignore: cast_nullable_to_non_nullable
as String,sourceDiscipline: null == sourceDiscipline ? _self.sourceDiscipline : sourceDiscipline // ignore: cast_nullable_to_non_nullable
as String,subjectEducationLevel: null == subjectEducationLevel ? _self.subjectEducationLevel : subjectEducationLevel // ignore: cast_nullable_to_non_nullable
as String,subjectDiscipline: null == subjectDiscipline ? _self.subjectDiscipline : subjectDiscipline // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QueryProfileRecord].
extension QueryProfileRecordPatterns on QueryProfileRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueryProfileRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueryProfileRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueryProfileRecord value)  $default,){
final _that = this;
switch (_that) {
case _QueryProfileRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueryProfileRecord value)?  $default,){
final _that = this;
switch (_that) {
case _QueryProfileRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int userId,  DateTime? queryDate,  String queryText,  String sourceDiscipline,  String subjectEducationLevel,  String subjectDiscipline,  String topic,  String goal,  String role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueryProfileRecord() when $default != null:
return $default(_that.id,_that.userId,_that.queryDate,_that.queryText,_that.sourceDiscipline,_that.subjectEducationLevel,_that.subjectDiscipline,_that.topic,_that.goal,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int userId,  DateTime? queryDate,  String queryText,  String sourceDiscipline,  String subjectEducationLevel,  String subjectDiscipline,  String topic,  String goal,  String role)  $default,) {final _that = this;
switch (_that) {
case _QueryProfileRecord():
return $default(_that.id,_that.userId,_that.queryDate,_that.queryText,_that.sourceDiscipline,_that.subjectEducationLevel,_that.subjectDiscipline,_that.topic,_that.goal,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int userId,  DateTime? queryDate,  String queryText,  String sourceDiscipline,  String subjectEducationLevel,  String subjectDiscipline,  String topic,  String goal,  String role)?  $default,) {final _that = this;
switch (_that) {
case _QueryProfileRecord() when $default != null:
return $default(_that.id,_that.userId,_that.queryDate,_that.queryText,_that.sourceDiscipline,_that.subjectEducationLevel,_that.subjectDiscipline,_that.topic,_that.goal,_that.role);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QueryProfileRecord implements QueryProfileRecord {
  const _QueryProfileRecord({this.id, required this.userId, this.queryDate, required this.queryText, required this.sourceDiscipline, required this.subjectEducationLevel, required this.subjectDiscipline, required this.topic, required this.goal, required this.role});
  factory _QueryProfileRecord.fromJson(Map<String, dynamic> json) => _$QueryProfileRecordFromJson(json);

/// Unique identifier for the record
@override final  int? id;
/// Reference to the user who made the query
@override final  int userId;
/// Date the query was made
@override final  DateTime? queryDate;
/// Original query text
@override final  String queryText;
/// The discipline or field of expertise of the source expert
@override final  String sourceDiscipline;
/// The education level of the subject
@override final  String subjectEducationLevel;
/// The primary discipline or field of study for the subject
@override final  String subjectDiscipline;
/// The specific topic or skill to be learned
@override final  String topic;
/// The goal for learning this skill
@override final  String goal;
/// The target role the subject wants to achieve
@override final  String role;

/// Create a copy of QueryProfileRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueryProfileRecordCopyWith<_QueryProfileRecord> get copyWith => __$QueryProfileRecordCopyWithImpl<_QueryProfileRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QueryProfileRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueryProfileRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.queryDate, queryDate) || other.queryDate == queryDate)&&(identical(other.queryText, queryText) || other.queryText == queryText)&&(identical(other.sourceDiscipline, sourceDiscipline) || other.sourceDiscipline == sourceDiscipline)&&(identical(other.subjectEducationLevel, subjectEducationLevel) || other.subjectEducationLevel == subjectEducationLevel)&&(identical(other.subjectDiscipline, subjectDiscipline) || other.subjectDiscipline == subjectDiscipline)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,queryDate,queryText,sourceDiscipline,subjectEducationLevel,subjectDiscipline,topic,goal,role);

@override
String toString() {
  return 'QueryProfileRecord(id: $id, userId: $userId, queryDate: $queryDate, queryText: $queryText, sourceDiscipline: $sourceDiscipline, subjectEducationLevel: $subjectEducationLevel, subjectDiscipline: $subjectDiscipline, topic: $topic, goal: $goal, role: $role)';
}


}

/// @nodoc
abstract mixin class _$QueryProfileRecordCopyWith<$Res> implements $QueryProfileRecordCopyWith<$Res> {
  factory _$QueryProfileRecordCopyWith(_QueryProfileRecord value, $Res Function(_QueryProfileRecord) _then) = __$QueryProfileRecordCopyWithImpl;
@override @useResult
$Res call({
 int? id, int userId, DateTime? queryDate, String queryText, String sourceDiscipline, String subjectEducationLevel, String subjectDiscipline, String topic, String goal, String role
});




}
/// @nodoc
class __$QueryProfileRecordCopyWithImpl<$Res>
    implements _$QueryProfileRecordCopyWith<$Res> {
  __$QueryProfileRecordCopyWithImpl(this._self, this._then);

  final _QueryProfileRecord _self;
  final $Res Function(_QueryProfileRecord) _then;

/// Create a copy of QueryProfileRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = null,Object? queryDate = freezed,Object? queryText = null,Object? sourceDiscipline = null,Object? subjectEducationLevel = null,Object? subjectDiscipline = null,Object? topic = null,Object? goal = null,Object? role = null,}) {
  return _then(_QueryProfileRecord(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,queryDate: freezed == queryDate ? _self.queryDate : queryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,queryText: null == queryText ? _self.queryText : queryText // ignore: cast_nullable_to_non_nullable
as String,sourceDiscipline: null == sourceDiscipline ? _self.sourceDiscipline : sourceDiscipline // ignore: cast_nullable_to_non_nullable
as String,subjectEducationLevel: null == subjectEducationLevel ? _self.subjectEducationLevel : subjectEducationLevel // ignore: cast_nullable_to_non_nullable
as String,subjectDiscipline: null == subjectDiscipline ? _self.subjectDiscipline : subjectDiscipline // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

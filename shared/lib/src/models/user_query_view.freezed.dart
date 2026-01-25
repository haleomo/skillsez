// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_query_view.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserQueryView {

/// User ID
 int get userId;/// User's email
 String get email;/// User's last name
 String get lastName;/// User's creation date
 DateTime? get createdAt;/// Query ID
 int get queryId;/// Date the query was made
 DateTime? get queryDate;/// Original query text
 String get queryText;/// Source discipline
 String get sourceDiscipline;/// Subject education level
 String get subjectEducationLevel;/// Subject discipline
 String get subjectDiscipline;/// Subject work experience
 String get subjectWorkExperience;/// Topic
 String get topic;/// Goal
 String get goal;/// Role
 String get role;
/// Create a copy of UserQueryView
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserQueryViewCopyWith<UserQueryView> get copyWith => _$UserQueryViewCopyWithImpl<UserQueryView>(this as UserQueryView, _$identity);

  /// Serializes this UserQueryView to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserQueryView&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.queryId, queryId) || other.queryId == queryId)&&(identical(other.queryDate, queryDate) || other.queryDate == queryDate)&&(identical(other.queryText, queryText) || other.queryText == queryText)&&(identical(other.sourceDiscipline, sourceDiscipline) || other.sourceDiscipline == sourceDiscipline)&&(identical(other.subjectEducationLevel, subjectEducationLevel) || other.subjectEducationLevel == subjectEducationLevel)&&(identical(other.subjectDiscipline, subjectDiscipline) || other.subjectDiscipline == subjectDiscipline)&&(identical(other.subjectWorkExperience, subjectWorkExperience) || other.subjectWorkExperience == subjectWorkExperience)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,email,lastName,createdAt,queryId,queryDate,queryText,sourceDiscipline,subjectEducationLevel,subjectDiscipline,subjectWorkExperience,topic,goal,role);

@override
String toString() {
  return 'UserQueryView(userId: $userId, email: $email, lastName: $lastName, createdAt: $createdAt, queryId: $queryId, queryDate: $queryDate, queryText: $queryText, sourceDiscipline: $sourceDiscipline, subjectEducationLevel: $subjectEducationLevel, subjectDiscipline: $subjectDiscipline, subjectWorkExperience: $subjectWorkExperience, topic: $topic, goal: $goal, role: $role)';
}


}

/// @nodoc
abstract mixin class $UserQueryViewCopyWith<$Res>  {
  factory $UserQueryViewCopyWith(UserQueryView value, $Res Function(UserQueryView) _then) = _$UserQueryViewCopyWithImpl;
@useResult
$Res call({
 int userId, String email, String lastName, DateTime? createdAt, int queryId, DateTime? queryDate, String queryText, String sourceDiscipline, String subjectEducationLevel, String subjectDiscipline, String subjectWorkExperience, String topic, String goal, String role
});




}
/// @nodoc
class _$UserQueryViewCopyWithImpl<$Res>
    implements $UserQueryViewCopyWith<$Res> {
  _$UserQueryViewCopyWithImpl(this._self, this._then);

  final UserQueryView _self;
  final $Res Function(UserQueryView) _then;

/// Create a copy of UserQueryView
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? email = null,Object? lastName = null,Object? createdAt = freezed,Object? queryId = null,Object? queryDate = freezed,Object? queryText = null,Object? sourceDiscipline = null,Object? subjectEducationLevel = null,Object? subjectDiscipline = null,Object? subjectWorkExperience = null,Object? topic = null,Object? goal = null,Object? role = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,queryId: null == queryId ? _self.queryId : queryId // ignore: cast_nullable_to_non_nullable
as int,queryDate: freezed == queryDate ? _self.queryDate : queryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,queryText: null == queryText ? _self.queryText : queryText // ignore: cast_nullable_to_non_nullable
as String,sourceDiscipline: null == sourceDiscipline ? _self.sourceDiscipline : sourceDiscipline // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [UserQueryView].
extension UserQueryViewPatterns on UserQueryView {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserQueryView value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserQueryView() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserQueryView value)  $default,){
final _that = this;
switch (_that) {
case _UserQueryView():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserQueryView value)?  $default,){
final _that = this;
switch (_that) {
case _UserQueryView() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userId,  String email,  String lastName,  DateTime? createdAt,  int queryId,  DateTime? queryDate,  String queryText,  String sourceDiscipline,  String subjectEducationLevel,  String subjectDiscipline,  String subjectWorkExperience,  String topic,  String goal,  String role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserQueryView() when $default != null:
return $default(_that.userId,_that.email,_that.lastName,_that.createdAt,_that.queryId,_that.queryDate,_that.queryText,_that.sourceDiscipline,_that.subjectEducationLevel,_that.subjectDiscipline,_that.subjectWorkExperience,_that.topic,_that.goal,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userId,  String email,  String lastName,  DateTime? createdAt,  int queryId,  DateTime? queryDate,  String queryText,  String sourceDiscipline,  String subjectEducationLevel,  String subjectDiscipline,  String subjectWorkExperience,  String topic,  String goal,  String role)  $default,) {final _that = this;
switch (_that) {
case _UserQueryView():
return $default(_that.userId,_that.email,_that.lastName,_that.createdAt,_that.queryId,_that.queryDate,_that.queryText,_that.sourceDiscipline,_that.subjectEducationLevel,_that.subjectDiscipline,_that.subjectWorkExperience,_that.topic,_that.goal,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userId,  String email,  String lastName,  DateTime? createdAt,  int queryId,  DateTime? queryDate,  String queryText,  String sourceDiscipline,  String subjectEducationLevel,  String subjectDiscipline,  String subjectWorkExperience,  String topic,  String goal,  String role)?  $default,) {final _that = this;
switch (_that) {
case _UserQueryView() when $default != null:
return $default(_that.userId,_that.email,_that.lastName,_that.createdAt,_that.queryId,_that.queryDate,_that.queryText,_that.sourceDiscipline,_that.subjectEducationLevel,_that.subjectDiscipline,_that.subjectWorkExperience,_that.topic,_that.goal,_that.role);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserQueryView implements UserQueryView {
  const _UserQueryView({required this.userId, required this.email, required this.lastName, this.createdAt, required this.queryId, this.queryDate, required this.queryText, required this.sourceDiscipline, required this.subjectEducationLevel, required this.subjectDiscipline, required this.subjectWorkExperience, required this.topic, required this.goal, required this.role});
  factory _UserQueryView.fromJson(Map<String, dynamic> json) => _$UserQueryViewFromJson(json);

/// User ID
@override final  int userId;
/// User's email
@override final  String email;
/// User's last name
@override final  String lastName;
/// User's creation date
@override final  DateTime? createdAt;
/// Query ID
@override final  int queryId;
/// Date the query was made
@override final  DateTime? queryDate;
/// Original query text
@override final  String queryText;
/// Source discipline
@override final  String sourceDiscipline;
/// Subject education level
@override final  String subjectEducationLevel;
/// Subject discipline
@override final  String subjectDiscipline;
/// Subject work experience
@override final  String subjectWorkExperience;
/// Topic
@override final  String topic;
/// Goal
@override final  String goal;
/// Role
@override final  String role;

/// Create a copy of UserQueryView
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserQueryViewCopyWith<_UserQueryView> get copyWith => __$UserQueryViewCopyWithImpl<_UserQueryView>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserQueryViewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserQueryView&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.queryId, queryId) || other.queryId == queryId)&&(identical(other.queryDate, queryDate) || other.queryDate == queryDate)&&(identical(other.queryText, queryText) || other.queryText == queryText)&&(identical(other.sourceDiscipline, sourceDiscipline) || other.sourceDiscipline == sourceDiscipline)&&(identical(other.subjectEducationLevel, subjectEducationLevel) || other.subjectEducationLevel == subjectEducationLevel)&&(identical(other.subjectDiscipline, subjectDiscipline) || other.subjectDiscipline == subjectDiscipline)&&(identical(other.subjectWorkExperience, subjectWorkExperience) || other.subjectWorkExperience == subjectWorkExperience)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,email,lastName,createdAt,queryId,queryDate,queryText,sourceDiscipline,subjectEducationLevel,subjectDiscipline,subjectWorkExperience,topic,goal,role);

@override
String toString() {
  return 'UserQueryView(userId: $userId, email: $email, lastName: $lastName, createdAt: $createdAt, queryId: $queryId, queryDate: $queryDate, queryText: $queryText, sourceDiscipline: $sourceDiscipline, subjectEducationLevel: $subjectEducationLevel, subjectDiscipline: $subjectDiscipline, subjectWorkExperience: $subjectWorkExperience, topic: $topic, goal: $goal, role: $role)';
}


}

/// @nodoc
abstract mixin class _$UserQueryViewCopyWith<$Res> implements $UserQueryViewCopyWith<$Res> {
  factory _$UserQueryViewCopyWith(_UserQueryView value, $Res Function(_UserQueryView) _then) = __$UserQueryViewCopyWithImpl;
@override @useResult
$Res call({
 int userId, String email, String lastName, DateTime? createdAt, int queryId, DateTime? queryDate, String queryText, String sourceDiscipline, String subjectEducationLevel, String subjectDiscipline, String subjectWorkExperience, String topic, String goal, String role
});




}
/// @nodoc
class __$UserQueryViewCopyWithImpl<$Res>
    implements _$UserQueryViewCopyWith<$Res> {
  __$UserQueryViewCopyWithImpl(this._self, this._then);

  final _UserQueryView _self;
  final $Res Function(_UserQueryView) _then;

/// Create a copy of UserQueryView
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? email = null,Object? lastName = null,Object? createdAt = freezed,Object? queryId = null,Object? queryDate = freezed,Object? queryText = null,Object? sourceDiscipline = null,Object? subjectEducationLevel = null,Object? subjectDiscipline = null,Object? subjectWorkExperience = null,Object? topic = null,Object? goal = null,Object? role = null,}) {
  return _then(_UserQueryView(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,queryId: null == queryId ? _self.queryId : queryId // ignore: cast_nullable_to_non_nullable
as int,queryDate: freezed == queryDate ? _self.queryDate : queryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,queryText: null == queryText ? _self.queryText : queryText // ignore: cast_nullable_to_non_nullable
as String,sourceDiscipline: null == sourceDiscipline ? _self.sourceDiscipline : sourceDiscipline // ignore: cast_nullable_to_non_nullable
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

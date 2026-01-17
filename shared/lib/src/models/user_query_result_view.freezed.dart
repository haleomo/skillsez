// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_query_result_view.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserQueryResultView {

/// User's email
 String get email;/// User's last name
 String get lastName;/// Query result nickname
 String get queryResultNickname;/// Result text/content
 String get resultText;/// Date the result was saved
 DateTime? get resultDate;
/// Create a copy of UserQueryResultView
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserQueryResultViewCopyWith<UserQueryResultView> get copyWith => _$UserQueryResultViewCopyWithImpl<UserQueryResultView>(this as UserQueryResultView, _$identity);

  /// Serializes this UserQueryResultView to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserQueryResultView&&(identical(other.email, email) || other.email == email)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.queryResultNickname, queryResultNickname) || other.queryResultNickname == queryResultNickname)&&(identical(other.resultText, resultText) || other.resultText == resultText)&&(identical(other.resultDate, resultDate) || other.resultDate == resultDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,lastName,queryResultNickname,resultText,resultDate);

@override
String toString() {
  return 'UserQueryResultView(email: $email, lastName: $lastName, queryResultNickname: $queryResultNickname, resultText: $resultText, resultDate: $resultDate)';
}


}

/// @nodoc
abstract mixin class $UserQueryResultViewCopyWith<$Res>  {
  factory $UserQueryResultViewCopyWith(UserQueryResultView value, $Res Function(UserQueryResultView) _then) = _$UserQueryResultViewCopyWithImpl;
@useResult
$Res call({
 String email, String lastName, String queryResultNickname, String resultText, DateTime? resultDate
});




}
/// @nodoc
class _$UserQueryResultViewCopyWithImpl<$Res>
    implements $UserQueryResultViewCopyWith<$Res> {
  _$UserQueryResultViewCopyWithImpl(this._self, this._then);

  final UserQueryResultView _self;
  final $Res Function(UserQueryResultView) _then;

/// Create a copy of UserQueryResultView
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? lastName = null,Object? queryResultNickname = null,Object? resultText = null,Object? resultDate = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,queryResultNickname: null == queryResultNickname ? _self.queryResultNickname : queryResultNickname // ignore: cast_nullable_to_non_nullable
as String,resultText: null == resultText ? _self.resultText : resultText // ignore: cast_nullable_to_non_nullable
as String,resultDate: freezed == resultDate ? _self.resultDate : resultDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserQueryResultView].
extension UserQueryResultViewPatterns on UserQueryResultView {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserQueryResultView value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserQueryResultView() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserQueryResultView value)  $default,){
final _that = this;
switch (_that) {
case _UserQueryResultView():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserQueryResultView value)?  $default,){
final _that = this;
switch (_that) {
case _UserQueryResultView() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String lastName,  String queryResultNickname,  String resultText,  DateTime? resultDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserQueryResultView() when $default != null:
return $default(_that.email,_that.lastName,_that.queryResultNickname,_that.resultText,_that.resultDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String lastName,  String queryResultNickname,  String resultText,  DateTime? resultDate)  $default,) {final _that = this;
switch (_that) {
case _UserQueryResultView():
return $default(_that.email,_that.lastName,_that.queryResultNickname,_that.resultText,_that.resultDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String lastName,  String queryResultNickname,  String resultText,  DateTime? resultDate)?  $default,) {final _that = this;
switch (_that) {
case _UserQueryResultView() when $default != null:
return $default(_that.email,_that.lastName,_that.queryResultNickname,_that.resultText,_that.resultDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserQueryResultView implements UserQueryResultView {
  const _UserQueryResultView({required this.email, required this.lastName, required this.queryResultNickname, required this.resultText, this.resultDate});
  factory _UserQueryResultView.fromJson(Map<String, dynamic> json) => _$UserQueryResultViewFromJson(json);

/// User's email
@override final  String email;
/// User's last name
@override final  String lastName;
/// Query result nickname
@override final  String queryResultNickname;
/// Result text/content
@override final  String resultText;
/// Date the result was saved
@override final  DateTime? resultDate;

/// Create a copy of UserQueryResultView
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserQueryResultViewCopyWith<_UserQueryResultView> get copyWith => __$UserQueryResultViewCopyWithImpl<_UserQueryResultView>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserQueryResultViewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserQueryResultView&&(identical(other.email, email) || other.email == email)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.queryResultNickname, queryResultNickname) || other.queryResultNickname == queryResultNickname)&&(identical(other.resultText, resultText) || other.resultText == resultText)&&(identical(other.resultDate, resultDate) || other.resultDate == resultDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,lastName,queryResultNickname,resultText,resultDate);

@override
String toString() {
  return 'UserQueryResultView(email: $email, lastName: $lastName, queryResultNickname: $queryResultNickname, resultText: $resultText, resultDate: $resultDate)';
}


}

/// @nodoc
abstract mixin class _$UserQueryResultViewCopyWith<$Res> implements $UserQueryResultViewCopyWith<$Res> {
  factory _$UserQueryResultViewCopyWith(_UserQueryResultView value, $Res Function(_UserQueryResultView) _then) = __$UserQueryResultViewCopyWithImpl;
@override @useResult
$Res call({
 String email, String lastName, String queryResultNickname, String resultText, DateTime? resultDate
});




}
/// @nodoc
class __$UserQueryResultViewCopyWithImpl<$Res>
    implements _$UserQueryResultViewCopyWith<$Res> {
  __$UserQueryResultViewCopyWithImpl(this._self, this._then);

  final _UserQueryResultView _self;
  final $Res Function(_UserQueryResultView) _then;

/// Create a copy of UserQueryResultView
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? lastName = null,Object? queryResultNickname = null,Object? resultText = null,Object? resultDate = freezed,}) {
  return _then(_UserQueryResultView(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,queryResultNickname: null == queryResultNickname ? _self.queryResultNickname : queryResultNickname // ignore: cast_nullable_to_non_nullable
as String,resultText: null == resultText ? _self.resultText : resultText // ignore: cast_nullable_to_non_nullable
as String,resultDate: freezed == resultDate ? _self.resultDate : resultDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

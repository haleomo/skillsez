// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QueryResult {

/// Unique identifier for the query result
 int? get id;/// User-provided nickname for this plan
 String get queryResultNickname;/// Reference to the query profile that generated this result
 int get queryId;/// The actual result content (learning plan)
 String get resultText;/// Date the result was saved
 DateTime? get resultDate;
/// Create a copy of QueryResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueryResultCopyWith<QueryResult> get copyWith => _$QueryResultCopyWithImpl<QueryResult>(this as QueryResult, _$identity);

  /// Serializes this QueryResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueryResult&&(identical(other.id, id) || other.id == id)&&(identical(other.queryResultNickname, queryResultNickname) || other.queryResultNickname == queryResultNickname)&&(identical(other.queryId, queryId) || other.queryId == queryId)&&(identical(other.resultText, resultText) || other.resultText == resultText)&&(identical(other.resultDate, resultDate) || other.resultDate == resultDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,queryResultNickname,queryId,resultText,resultDate);

@override
String toString() {
  return 'QueryResult(id: $id, queryResultNickname: $queryResultNickname, queryId: $queryId, resultText: $resultText, resultDate: $resultDate)';
}


}

/// @nodoc
abstract mixin class $QueryResultCopyWith<$Res>  {
  factory $QueryResultCopyWith(QueryResult value, $Res Function(QueryResult) _then) = _$QueryResultCopyWithImpl;
@useResult
$Res call({
 int? id, String queryResultNickname, int queryId, String resultText, DateTime? resultDate
});




}
/// @nodoc
class _$QueryResultCopyWithImpl<$Res>
    implements $QueryResultCopyWith<$Res> {
  _$QueryResultCopyWithImpl(this._self, this._then);

  final QueryResult _self;
  final $Res Function(QueryResult) _then;

/// Create a copy of QueryResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? queryResultNickname = null,Object? queryId = null,Object? resultText = null,Object? resultDate = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,queryResultNickname: null == queryResultNickname ? _self.queryResultNickname : queryResultNickname // ignore: cast_nullable_to_non_nullable
as String,queryId: null == queryId ? _self.queryId : queryId // ignore: cast_nullable_to_non_nullable
as int,resultText: null == resultText ? _self.resultText : resultText // ignore: cast_nullable_to_non_nullable
as String,resultDate: freezed == resultDate ? _self.resultDate : resultDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [QueryResult].
extension QueryResultPatterns on QueryResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueryResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueryResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueryResult value)  $default,){
final _that = this;
switch (_that) {
case _QueryResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueryResult value)?  $default,){
final _that = this;
switch (_that) {
case _QueryResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String queryResultNickname,  int queryId,  String resultText,  DateTime? resultDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueryResult() when $default != null:
return $default(_that.id,_that.queryResultNickname,_that.queryId,_that.resultText,_that.resultDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String queryResultNickname,  int queryId,  String resultText,  DateTime? resultDate)  $default,) {final _that = this;
switch (_that) {
case _QueryResult():
return $default(_that.id,_that.queryResultNickname,_that.queryId,_that.resultText,_that.resultDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String queryResultNickname,  int queryId,  String resultText,  DateTime? resultDate)?  $default,) {final _that = this;
switch (_that) {
case _QueryResult() when $default != null:
return $default(_that.id,_that.queryResultNickname,_that.queryId,_that.resultText,_that.resultDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QueryResult implements QueryResult {
  const _QueryResult({this.id, required this.queryResultNickname, required this.queryId, required this.resultText, this.resultDate});
  factory _QueryResult.fromJson(Map<String, dynamic> json) => _$QueryResultFromJson(json);

/// Unique identifier for the query result
@override final  int? id;
/// User-provided nickname for this plan
@override final  String queryResultNickname;
/// Reference to the query profile that generated this result
@override final  int queryId;
/// The actual result content (learning plan)
@override final  String resultText;
/// Date the result was saved
@override final  DateTime? resultDate;

/// Create a copy of QueryResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueryResultCopyWith<_QueryResult> get copyWith => __$QueryResultCopyWithImpl<_QueryResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QueryResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueryResult&&(identical(other.id, id) || other.id == id)&&(identical(other.queryResultNickname, queryResultNickname) || other.queryResultNickname == queryResultNickname)&&(identical(other.queryId, queryId) || other.queryId == queryId)&&(identical(other.resultText, resultText) || other.resultText == resultText)&&(identical(other.resultDate, resultDate) || other.resultDate == resultDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,queryResultNickname,queryId,resultText,resultDate);

@override
String toString() {
  return 'QueryResult(id: $id, queryResultNickname: $queryResultNickname, queryId: $queryId, resultText: $resultText, resultDate: $resultDate)';
}


}

/// @nodoc
abstract mixin class _$QueryResultCopyWith<$Res> implements $QueryResultCopyWith<$Res> {
  factory _$QueryResultCopyWith(_QueryResult value, $Res Function(_QueryResult) _then) = __$QueryResultCopyWithImpl;
@override @useResult
$Res call({
 int? id, String queryResultNickname, int queryId, String resultText, DateTime? resultDate
});




}
/// @nodoc
class __$QueryResultCopyWithImpl<$Res>
    implements _$QueryResultCopyWith<$Res> {
  __$QueryResultCopyWithImpl(this._self, this._then);

  final _QueryResult _self;
  final $Res Function(_QueryResult) _then;

/// Create a copy of QueryResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? queryResultNickname = null,Object? queryId = null,Object? resultText = null,Object? resultDate = freezed,}) {
  return _then(_QueryResult(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,queryResultNickname: null == queryResultNickname ? _self.queryResultNickname : queryResultNickname // ignore: cast_nullable_to_non_nullable
as String,queryId: null == queryId ? _self.queryId : queryId // ignore: cast_nullable_to_non_nullable
as int,resultText: null == resultText ? _self.resultText : resultText // ignore: cast_nullable_to_non_nullable
as String,resultDate: freezed == resultDate ? _self.resultDate : resultDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

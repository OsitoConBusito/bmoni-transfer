// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rate_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RateDto {

 String get value; String get source; String get asOf;
/// Create a copy of RateDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RateDtoCopyWith<RateDto> get copyWith => _$RateDtoCopyWithImpl<RateDto>(this as RateDto, _$identity);

  /// Serializes this RateDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RateDto&&(identical(other.value, value) || other.value == value)&&(identical(other.source, source) || other.source == source)&&(identical(other.asOf, asOf) || other.asOf == asOf));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,source,asOf);

@override
String toString() {
  return 'RateDto(value: $value, source: $source, asOf: $asOf)';
}


}

/// @nodoc
abstract mixin class $RateDtoCopyWith<$Res>  {
  factory $RateDtoCopyWith(RateDto value, $Res Function(RateDto) _then) = _$RateDtoCopyWithImpl;
@useResult
$Res call({
 String value, String source, String asOf
});




}
/// @nodoc
class _$RateDtoCopyWithImpl<$Res>
    implements $RateDtoCopyWith<$Res> {
  _$RateDtoCopyWithImpl(this._self, this._then);

  final RateDto _self;
  final $Res Function(RateDto) _then;

/// Create a copy of RateDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? source = null,Object? asOf = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,asOf: null == asOf ? _self.asOf : asOf // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RateDto].
extension RateDtoPatterns on RateDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RateDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RateDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RateDto value)  $default,){
final _that = this;
switch (_that) {
case _RateDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RateDto value)?  $default,){
final _that = this;
switch (_that) {
case _RateDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value,  String source,  String asOf)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RateDto() when $default != null:
return $default(_that.value,_that.source,_that.asOf);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value,  String source,  String asOf)  $default,) {final _that = this;
switch (_that) {
case _RateDto():
return $default(_that.value,_that.source,_that.asOf);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value,  String source,  String asOf)?  $default,) {final _that = this;
switch (_that) {
case _RateDto() when $default != null:
return $default(_that.value,_that.source,_that.asOf);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RateDto implements RateDto {
  const _RateDto({required this.value, required this.source, required this.asOf});
  factory _RateDto.fromJson(Map<String, dynamic> json) => _$RateDtoFromJson(json);

@override final  String value;
@override final  String source;
@override final  String asOf;

/// Create a copy of RateDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RateDtoCopyWith<_RateDto> get copyWith => __$RateDtoCopyWithImpl<_RateDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RateDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RateDto&&(identical(other.value, value) || other.value == value)&&(identical(other.source, source) || other.source == source)&&(identical(other.asOf, asOf) || other.asOf == asOf));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,source,asOf);

@override
String toString() {
  return 'RateDto(value: $value, source: $source, asOf: $asOf)';
}


}

/// @nodoc
abstract mixin class _$RateDtoCopyWith<$Res> implements $RateDtoCopyWith<$Res> {
  factory _$RateDtoCopyWith(_RateDto value, $Res Function(_RateDto) _then) = __$RateDtoCopyWithImpl;
@override @useResult
$Res call({
 String value, String source, String asOf
});




}
/// @nodoc
class __$RateDtoCopyWithImpl<$Res>
    implements _$RateDtoCopyWith<$Res> {
  __$RateDtoCopyWithImpl(this._self, this._then);

  final _RateDto _self;
  final $Res Function(_RateDto) _then;

/// Create a copy of RateDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? source = null,Object? asOf = null,}) {
  return _then(_RateDto(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,asOf: null == asOf ? _self.asOf : asOf // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuoteDto {

 String get quoteId; MoneyDto get sourceAmount; MoneyDto get fee; MoneyDto get destAmount; RateDto get rate; String get expiresAt;
/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteDtoCopyWith<QuoteDto> get copyWith => _$QuoteDtoCopyWithImpl<QuoteDto>(this as QuoteDto, _$identity);

  /// Serializes this QuoteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteDto&&(identical(other.quoteId, quoteId) || other.quoteId == quoteId)&&(identical(other.sourceAmount, sourceAmount) || other.sourceAmount == sourceAmount)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.destAmount, destAmount) || other.destAmount == destAmount)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,quoteId,sourceAmount,fee,destAmount,rate,expiresAt);

@override
String toString() {
  return 'QuoteDto(quoteId: $quoteId, sourceAmount: $sourceAmount, fee: $fee, destAmount: $destAmount, rate: $rate, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $QuoteDtoCopyWith<$Res>  {
  factory $QuoteDtoCopyWith(QuoteDto value, $Res Function(QuoteDto) _then) = _$QuoteDtoCopyWithImpl;
@useResult
$Res call({
 String quoteId, MoneyDto sourceAmount, MoneyDto fee, MoneyDto destAmount, RateDto rate, String expiresAt
});


$MoneyDtoCopyWith<$Res> get sourceAmount;$MoneyDtoCopyWith<$Res> get fee;$MoneyDtoCopyWith<$Res> get destAmount;$RateDtoCopyWith<$Res> get rate;

}
/// @nodoc
class _$QuoteDtoCopyWithImpl<$Res>
    implements $QuoteDtoCopyWith<$Res> {
  _$QuoteDtoCopyWithImpl(this._self, this._then);

  final QuoteDto _self;
  final $Res Function(QuoteDto) _then;

/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quoteId = null,Object? sourceAmount = null,Object? fee = null,Object? destAmount = null,Object? rate = null,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
quoteId: null == quoteId ? _self.quoteId : quoteId // ignore: cast_nullable_to_non_nullable
as String,sourceAmount: null == sourceAmount ? _self.sourceAmount : sourceAmount // ignore: cast_nullable_to_non_nullable
as MoneyDto,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as MoneyDto,destAmount: null == destAmount ? _self.destAmount : destAmount // ignore: cast_nullable_to_non_nullable
as MoneyDto,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as RateDto,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyDtoCopyWith<$Res> get sourceAmount {
  
  return $MoneyDtoCopyWith<$Res>(_self.sourceAmount, (value) {
    return _then(_self.copyWith(sourceAmount: value));
  });
}/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyDtoCopyWith<$Res> get fee {
  
  return $MoneyDtoCopyWith<$Res>(_self.fee, (value) {
    return _then(_self.copyWith(fee: value));
  });
}/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyDtoCopyWith<$Res> get destAmount {
  
  return $MoneyDtoCopyWith<$Res>(_self.destAmount, (value) {
    return _then(_self.copyWith(destAmount: value));
  });
}/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RateDtoCopyWith<$Res> get rate {
  
  return $RateDtoCopyWith<$Res>(_self.rate, (value) {
    return _then(_self.copyWith(rate: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuoteDto].
extension QuoteDtoPatterns on QuoteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuoteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuoteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuoteDto value)  $default,){
final _that = this;
switch (_that) {
case _QuoteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuoteDto value)?  $default,){
final _that = this;
switch (_that) {
case _QuoteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String quoteId,  MoneyDto sourceAmount,  MoneyDto fee,  MoneyDto destAmount,  RateDto rate,  String expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteDto() when $default != null:
return $default(_that.quoteId,_that.sourceAmount,_that.fee,_that.destAmount,_that.rate,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String quoteId,  MoneyDto sourceAmount,  MoneyDto fee,  MoneyDto destAmount,  RateDto rate,  String expiresAt)  $default,) {final _that = this;
switch (_that) {
case _QuoteDto():
return $default(_that.quoteId,_that.sourceAmount,_that.fee,_that.destAmount,_that.rate,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String quoteId,  MoneyDto sourceAmount,  MoneyDto fee,  MoneyDto destAmount,  RateDto rate,  String expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _QuoteDto() when $default != null:
return $default(_that.quoteId,_that.sourceAmount,_that.fee,_that.destAmount,_that.rate,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuoteDto implements QuoteDto {
  const _QuoteDto({required this.quoteId, required this.sourceAmount, required this.fee, required this.destAmount, required this.rate, required this.expiresAt});
  factory _QuoteDto.fromJson(Map<String, dynamic> json) => _$QuoteDtoFromJson(json);

@override final  String quoteId;
@override final  MoneyDto sourceAmount;
@override final  MoneyDto fee;
@override final  MoneyDto destAmount;
@override final  RateDto rate;
@override final  String expiresAt;

/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteDtoCopyWith<_QuoteDto> get copyWith => __$QuoteDtoCopyWithImpl<_QuoteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteDto&&(identical(other.quoteId, quoteId) || other.quoteId == quoteId)&&(identical(other.sourceAmount, sourceAmount) || other.sourceAmount == sourceAmount)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.destAmount, destAmount) || other.destAmount == destAmount)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,quoteId,sourceAmount,fee,destAmount,rate,expiresAt);

@override
String toString() {
  return 'QuoteDto(quoteId: $quoteId, sourceAmount: $sourceAmount, fee: $fee, destAmount: $destAmount, rate: $rate, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$QuoteDtoCopyWith<$Res> implements $QuoteDtoCopyWith<$Res> {
  factory _$QuoteDtoCopyWith(_QuoteDto value, $Res Function(_QuoteDto) _then) = __$QuoteDtoCopyWithImpl;
@override @useResult
$Res call({
 String quoteId, MoneyDto sourceAmount, MoneyDto fee, MoneyDto destAmount, RateDto rate, String expiresAt
});


@override $MoneyDtoCopyWith<$Res> get sourceAmount;@override $MoneyDtoCopyWith<$Res> get fee;@override $MoneyDtoCopyWith<$Res> get destAmount;@override $RateDtoCopyWith<$Res> get rate;

}
/// @nodoc
class __$QuoteDtoCopyWithImpl<$Res>
    implements _$QuoteDtoCopyWith<$Res> {
  __$QuoteDtoCopyWithImpl(this._self, this._then);

  final _QuoteDto _self;
  final $Res Function(_QuoteDto) _then;

/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quoteId = null,Object? sourceAmount = null,Object? fee = null,Object? destAmount = null,Object? rate = null,Object? expiresAt = null,}) {
  return _then(_QuoteDto(
quoteId: null == quoteId ? _self.quoteId : quoteId // ignore: cast_nullable_to_non_nullable
as String,sourceAmount: null == sourceAmount ? _self.sourceAmount : sourceAmount // ignore: cast_nullable_to_non_nullable
as MoneyDto,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as MoneyDto,destAmount: null == destAmount ? _self.destAmount : destAmount // ignore: cast_nullable_to_non_nullable
as MoneyDto,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as RateDto,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyDtoCopyWith<$Res> get sourceAmount {
  
  return $MoneyDtoCopyWith<$Res>(_self.sourceAmount, (value) {
    return _then(_self.copyWith(sourceAmount: value));
  });
}/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyDtoCopyWith<$Res> get fee {
  
  return $MoneyDtoCopyWith<$Res>(_self.fee, (value) {
    return _then(_self.copyWith(fee: value));
  });
}/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyDtoCopyWith<$Res> get destAmount {
  
  return $MoneyDtoCopyWith<$Res>(_self.destAmount, (value) {
    return _then(_self.copyWith(destAmount: value));
  });
}/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RateDtoCopyWith<$Res> get rate {
  
  return $RateDtoCopyWith<$Res>(_self.rate, (value) {
    return _then(_self.copyWith(rate: value));
  });
}
}

// dart format on

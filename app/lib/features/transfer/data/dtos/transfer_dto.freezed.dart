// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransferDto {

 String get transferId; String get status; String get quoteId; MoneyDto get sourceAmount; MoneyDto get destAmount; MoneyDto get fee; RateDto get rate; String get createdAt;
/// Create a copy of TransferDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferDtoCopyWith<TransferDto> get copyWith => _$TransferDtoCopyWithImpl<TransferDto>(this as TransferDto, _$identity);

  /// Serializes this TransferDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransferDto&&(identical(other.transferId, transferId) || other.transferId == transferId)&&(identical(other.status, status) || other.status == status)&&(identical(other.quoteId, quoteId) || other.quoteId == quoteId)&&(identical(other.sourceAmount, sourceAmount) || other.sourceAmount == sourceAmount)&&(identical(other.destAmount, destAmount) || other.destAmount == destAmount)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transferId,status,quoteId,sourceAmount,destAmount,fee,rate,createdAt);

@override
String toString() {
  return 'TransferDto(transferId: $transferId, status: $status, quoteId: $quoteId, sourceAmount: $sourceAmount, destAmount: $destAmount, fee: $fee, rate: $rate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TransferDtoCopyWith<$Res>  {
  factory $TransferDtoCopyWith(TransferDto value, $Res Function(TransferDto) _then) = _$TransferDtoCopyWithImpl;
@useResult
$Res call({
 String transferId, String status, String quoteId, MoneyDto sourceAmount, MoneyDto destAmount, MoneyDto fee, RateDto rate, String createdAt
});


$MoneyDtoCopyWith<$Res> get sourceAmount;$MoneyDtoCopyWith<$Res> get destAmount;$MoneyDtoCopyWith<$Res> get fee;$RateDtoCopyWith<$Res> get rate;

}
/// @nodoc
class _$TransferDtoCopyWithImpl<$Res>
    implements $TransferDtoCopyWith<$Res> {
  _$TransferDtoCopyWithImpl(this._self, this._then);

  final TransferDto _self;
  final $Res Function(TransferDto) _then;

/// Create a copy of TransferDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transferId = null,Object? status = null,Object? quoteId = null,Object? sourceAmount = null,Object? destAmount = null,Object? fee = null,Object? rate = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
transferId: null == transferId ? _self.transferId : transferId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,quoteId: null == quoteId ? _self.quoteId : quoteId // ignore: cast_nullable_to_non_nullable
as String,sourceAmount: null == sourceAmount ? _self.sourceAmount : sourceAmount // ignore: cast_nullable_to_non_nullable
as MoneyDto,destAmount: null == destAmount ? _self.destAmount : destAmount // ignore: cast_nullable_to_non_nullable
as MoneyDto,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as MoneyDto,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as RateDto,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of TransferDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyDtoCopyWith<$Res> get sourceAmount {
  
  return $MoneyDtoCopyWith<$Res>(_self.sourceAmount, (value) {
    return _then(_self.copyWith(sourceAmount: value));
  });
}/// Create a copy of TransferDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyDtoCopyWith<$Res> get destAmount {
  
  return $MoneyDtoCopyWith<$Res>(_self.destAmount, (value) {
    return _then(_self.copyWith(destAmount: value));
  });
}/// Create a copy of TransferDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyDtoCopyWith<$Res> get fee {
  
  return $MoneyDtoCopyWith<$Res>(_self.fee, (value) {
    return _then(_self.copyWith(fee: value));
  });
}/// Create a copy of TransferDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RateDtoCopyWith<$Res> get rate {
  
  return $RateDtoCopyWith<$Res>(_self.rate, (value) {
    return _then(_self.copyWith(rate: value));
  });
}
}


/// Adds pattern-matching-related methods to [TransferDto].
extension TransferDtoPatterns on TransferDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransferDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransferDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransferDto value)  $default,){
final _that = this;
switch (_that) {
case _TransferDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransferDto value)?  $default,){
final _that = this;
switch (_that) {
case _TransferDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String transferId,  String status,  String quoteId,  MoneyDto sourceAmount,  MoneyDto destAmount,  MoneyDto fee,  RateDto rate,  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransferDto() when $default != null:
return $default(_that.transferId,_that.status,_that.quoteId,_that.sourceAmount,_that.destAmount,_that.fee,_that.rate,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String transferId,  String status,  String quoteId,  MoneyDto sourceAmount,  MoneyDto destAmount,  MoneyDto fee,  RateDto rate,  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _TransferDto():
return $default(_that.transferId,_that.status,_that.quoteId,_that.sourceAmount,_that.destAmount,_that.fee,_that.rate,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String transferId,  String status,  String quoteId,  MoneyDto sourceAmount,  MoneyDto destAmount,  MoneyDto fee,  RateDto rate,  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TransferDto() when $default != null:
return $default(_that.transferId,_that.status,_that.quoteId,_that.sourceAmount,_that.destAmount,_that.fee,_that.rate,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransferDto implements TransferDto {
  const _TransferDto({required this.transferId, required this.status, required this.quoteId, required this.sourceAmount, required this.destAmount, required this.fee, required this.rate, required this.createdAt});
  factory _TransferDto.fromJson(Map<String, dynamic> json) => _$TransferDtoFromJson(json);

@override final  String transferId;
@override final  String status;
@override final  String quoteId;
@override final  MoneyDto sourceAmount;
@override final  MoneyDto destAmount;
@override final  MoneyDto fee;
@override final  RateDto rate;
@override final  String createdAt;

/// Create a copy of TransferDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferDtoCopyWith<_TransferDto> get copyWith => __$TransferDtoCopyWithImpl<_TransferDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransferDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferDto&&(identical(other.transferId, transferId) || other.transferId == transferId)&&(identical(other.status, status) || other.status == status)&&(identical(other.quoteId, quoteId) || other.quoteId == quoteId)&&(identical(other.sourceAmount, sourceAmount) || other.sourceAmount == sourceAmount)&&(identical(other.destAmount, destAmount) || other.destAmount == destAmount)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transferId,status,quoteId,sourceAmount,destAmount,fee,rate,createdAt);

@override
String toString() {
  return 'TransferDto(transferId: $transferId, status: $status, quoteId: $quoteId, sourceAmount: $sourceAmount, destAmount: $destAmount, fee: $fee, rate: $rate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TransferDtoCopyWith<$Res> implements $TransferDtoCopyWith<$Res> {
  factory _$TransferDtoCopyWith(_TransferDto value, $Res Function(_TransferDto) _then) = __$TransferDtoCopyWithImpl;
@override @useResult
$Res call({
 String transferId, String status, String quoteId, MoneyDto sourceAmount, MoneyDto destAmount, MoneyDto fee, RateDto rate, String createdAt
});


@override $MoneyDtoCopyWith<$Res> get sourceAmount;@override $MoneyDtoCopyWith<$Res> get destAmount;@override $MoneyDtoCopyWith<$Res> get fee;@override $RateDtoCopyWith<$Res> get rate;

}
/// @nodoc
class __$TransferDtoCopyWithImpl<$Res>
    implements _$TransferDtoCopyWith<$Res> {
  __$TransferDtoCopyWithImpl(this._self, this._then);

  final _TransferDto _self;
  final $Res Function(_TransferDto) _then;

/// Create a copy of TransferDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transferId = null,Object? status = null,Object? quoteId = null,Object? sourceAmount = null,Object? destAmount = null,Object? fee = null,Object? rate = null,Object? createdAt = null,}) {
  return _then(_TransferDto(
transferId: null == transferId ? _self.transferId : transferId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,quoteId: null == quoteId ? _self.quoteId : quoteId // ignore: cast_nullable_to_non_nullable
as String,sourceAmount: null == sourceAmount ? _self.sourceAmount : sourceAmount // ignore: cast_nullable_to_non_nullable
as MoneyDto,destAmount: null == destAmount ? _self.destAmount : destAmount // ignore: cast_nullable_to_non_nullable
as MoneyDto,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as MoneyDto,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as RateDto,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of TransferDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyDtoCopyWith<$Res> get sourceAmount {
  
  return $MoneyDtoCopyWith<$Res>(_self.sourceAmount, (value) {
    return _then(_self.copyWith(sourceAmount: value));
  });
}/// Create a copy of TransferDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyDtoCopyWith<$Res> get destAmount {
  
  return $MoneyDtoCopyWith<$Res>(_self.destAmount, (value) {
    return _then(_self.copyWith(destAmount: value));
  });
}/// Create a copy of TransferDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyDtoCopyWith<$Res> get fee {
  
  return $MoneyDtoCopyWith<$Res>(_self.fee, (value) {
    return _then(_self.copyWith(fee: value));
  });
}/// Create a copy of TransferDto
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

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Quote {

 String get id; Money get sourceAmount; Money get fee; FeeBreakdown get feeBreakdown; Money get destAmount; Rate get rate; DateTime get createdAt; DateTime get expiresAt;
/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteCopyWith<Quote> get copyWith => _$QuoteCopyWithImpl<Quote>(this as Quote, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Quote&&(identical(other.id, id) || other.id == id)&&(identical(other.sourceAmount, sourceAmount) || other.sourceAmount == sourceAmount)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.feeBreakdown, feeBreakdown) || other.feeBreakdown == feeBreakdown)&&(identical(other.destAmount, destAmount) || other.destAmount == destAmount)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,sourceAmount,fee,feeBreakdown,destAmount,rate,createdAt,expiresAt);

@override
String toString() {
  return 'Quote(id: $id, sourceAmount: $sourceAmount, fee: $fee, feeBreakdown: $feeBreakdown, destAmount: $destAmount, rate: $rate, createdAt: $createdAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $QuoteCopyWith<$Res>  {
  factory $QuoteCopyWith(Quote value, $Res Function(Quote) _then) = _$QuoteCopyWithImpl;
@useResult
$Res call({
 String id, Money sourceAmount, Money fee, FeeBreakdown feeBreakdown, Money destAmount, Rate rate, DateTime createdAt, DateTime expiresAt
});


$MoneyCopyWith<$Res> get sourceAmount;$MoneyCopyWith<$Res> get fee;$FeeBreakdownCopyWith<$Res> get feeBreakdown;$MoneyCopyWith<$Res> get destAmount;$RateCopyWith<$Res> get rate;

}
/// @nodoc
class _$QuoteCopyWithImpl<$Res>
    implements $QuoteCopyWith<$Res> {
  _$QuoteCopyWithImpl(this._self, this._then);

  final Quote _self;
  final $Res Function(Quote) _then;

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sourceAmount = null,Object? fee = null,Object? feeBreakdown = null,Object? destAmount = null,Object? rate = null,Object? createdAt = null,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sourceAmount: null == sourceAmount ? _self.sourceAmount : sourceAmount // ignore: cast_nullable_to_non_nullable
as Money,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as Money,feeBreakdown: null == feeBreakdown ? _self.feeBreakdown : feeBreakdown // ignore: cast_nullable_to_non_nullable
as FeeBreakdown,destAmount: null == destAmount ? _self.destAmount : destAmount // ignore: cast_nullable_to_non_nullable
as Money,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as Rate,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyCopyWith<$Res> get sourceAmount {
  
  return $MoneyCopyWith<$Res>(_self.sourceAmount, (value) {
    return _then(_self.copyWith(sourceAmount: value));
  });
}/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyCopyWith<$Res> get fee {
  
  return $MoneyCopyWith<$Res>(_self.fee, (value) {
    return _then(_self.copyWith(fee: value));
  });
}/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeeBreakdownCopyWith<$Res> get feeBreakdown {
  
  return $FeeBreakdownCopyWith<$Res>(_self.feeBreakdown, (value) {
    return _then(_self.copyWith(feeBreakdown: value));
  });
}/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyCopyWith<$Res> get destAmount {
  
  return $MoneyCopyWith<$Res>(_self.destAmount, (value) {
    return _then(_self.copyWith(destAmount: value));
  });
}/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RateCopyWith<$Res> get rate {
  
  return $RateCopyWith<$Res>(_self.rate, (value) {
    return _then(_self.copyWith(rate: value));
  });
}
}


/// Adds pattern-matching-related methods to [Quote].
extension QuotePatterns on Quote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Quote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Quote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Quote value)  $default,){
final _that = this;
switch (_that) {
case _Quote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Quote value)?  $default,){
final _that = this;
switch (_that) {
case _Quote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Money sourceAmount,  Money fee,  FeeBreakdown feeBreakdown,  Money destAmount,  Rate rate,  DateTime createdAt,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Quote() when $default != null:
return $default(_that.id,_that.sourceAmount,_that.fee,_that.feeBreakdown,_that.destAmount,_that.rate,_that.createdAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Money sourceAmount,  Money fee,  FeeBreakdown feeBreakdown,  Money destAmount,  Rate rate,  DateTime createdAt,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _Quote():
return $default(_that.id,_that.sourceAmount,_that.fee,_that.feeBreakdown,_that.destAmount,_that.rate,_that.createdAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Money sourceAmount,  Money fee,  FeeBreakdown feeBreakdown,  Money destAmount,  Rate rate,  DateTime createdAt,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _Quote() when $default != null:
return $default(_that.id,_that.sourceAmount,_that.fee,_that.feeBreakdown,_that.destAmount,_that.rate,_that.createdAt,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc


class _Quote extends Quote {
  const _Quote({required this.id, required this.sourceAmount, required this.fee, required this.feeBreakdown, required this.destAmount, required this.rate, required this.createdAt, required this.expiresAt}): super._();
  

@override final  String id;
@override final  Money sourceAmount;
@override final  Money fee;
@override final  FeeBreakdown feeBreakdown;
@override final  Money destAmount;
@override final  Rate rate;
@override final  DateTime createdAt;
@override final  DateTime expiresAt;

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteCopyWith<_Quote> get copyWith => __$QuoteCopyWithImpl<_Quote>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Quote&&(identical(other.id, id) || other.id == id)&&(identical(other.sourceAmount, sourceAmount) || other.sourceAmount == sourceAmount)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.feeBreakdown, feeBreakdown) || other.feeBreakdown == feeBreakdown)&&(identical(other.destAmount, destAmount) || other.destAmount == destAmount)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,sourceAmount,fee,feeBreakdown,destAmount,rate,createdAt,expiresAt);

@override
String toString() {
  return 'Quote(id: $id, sourceAmount: $sourceAmount, fee: $fee, feeBreakdown: $feeBreakdown, destAmount: $destAmount, rate: $rate, createdAt: $createdAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$QuoteCopyWith<$Res> implements $QuoteCopyWith<$Res> {
  factory _$QuoteCopyWith(_Quote value, $Res Function(_Quote) _then) = __$QuoteCopyWithImpl;
@override @useResult
$Res call({
 String id, Money sourceAmount, Money fee, FeeBreakdown feeBreakdown, Money destAmount, Rate rate, DateTime createdAt, DateTime expiresAt
});


@override $MoneyCopyWith<$Res> get sourceAmount;@override $MoneyCopyWith<$Res> get fee;@override $FeeBreakdownCopyWith<$Res> get feeBreakdown;@override $MoneyCopyWith<$Res> get destAmount;@override $RateCopyWith<$Res> get rate;

}
/// @nodoc
class __$QuoteCopyWithImpl<$Res>
    implements _$QuoteCopyWith<$Res> {
  __$QuoteCopyWithImpl(this._self, this._then);

  final _Quote _self;
  final $Res Function(_Quote) _then;

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sourceAmount = null,Object? fee = null,Object? feeBreakdown = null,Object? destAmount = null,Object? rate = null,Object? createdAt = null,Object? expiresAt = null,}) {
  return _then(_Quote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sourceAmount: null == sourceAmount ? _self.sourceAmount : sourceAmount // ignore: cast_nullable_to_non_nullable
as Money,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as Money,feeBreakdown: null == feeBreakdown ? _self.feeBreakdown : feeBreakdown // ignore: cast_nullable_to_non_nullable
as FeeBreakdown,destAmount: null == destAmount ? _self.destAmount : destAmount // ignore: cast_nullable_to_non_nullable
as Money,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as Rate,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyCopyWith<$Res> get sourceAmount {
  
  return $MoneyCopyWith<$Res>(_self.sourceAmount, (value) {
    return _then(_self.copyWith(sourceAmount: value));
  });
}/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyCopyWith<$Res> get fee {
  
  return $MoneyCopyWith<$Res>(_self.fee, (value) {
    return _then(_self.copyWith(fee: value));
  });
}/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeeBreakdownCopyWith<$Res> get feeBreakdown {
  
  return $FeeBreakdownCopyWith<$Res>(_self.feeBreakdown, (value) {
    return _then(_self.copyWith(feeBreakdown: value));
  });
}/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyCopyWith<$Res> get destAmount {
  
  return $MoneyCopyWith<$Res>(_self.destAmount, (value) {
    return _then(_self.copyWith(destAmount: value));
  });
}/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RateCopyWith<$Res> get rate {
  
  return $RateCopyWith<$Res>(_self.rate, (value) {
    return _then(_self.copyWith(rate: value));
  });
}
}

// dart format on

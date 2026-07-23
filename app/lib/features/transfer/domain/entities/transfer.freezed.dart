// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Transfer {

 String get id; TransferStatus get status; Money get sourceAmount; Money get destAmount; Money get fee; Rate get rate; DateTime get createdAt;
/// Create a copy of Transfer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferCopyWith<Transfer> get copyWith => _$TransferCopyWithImpl<Transfer>(this as Transfer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Transfer&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.sourceAmount, sourceAmount) || other.sourceAmount == sourceAmount)&&(identical(other.destAmount, destAmount) || other.destAmount == destAmount)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,status,sourceAmount,destAmount,fee,rate,createdAt);

@override
String toString() {
  return 'Transfer(id: $id, status: $status, sourceAmount: $sourceAmount, destAmount: $destAmount, fee: $fee, rate: $rate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TransferCopyWith<$Res>  {
  factory $TransferCopyWith(Transfer value, $Res Function(Transfer) _then) = _$TransferCopyWithImpl;
@useResult
$Res call({
 String id, TransferStatus status, Money sourceAmount, Money destAmount, Money fee, Rate rate, DateTime createdAt
});


$MoneyCopyWith<$Res> get sourceAmount;$MoneyCopyWith<$Res> get destAmount;$MoneyCopyWith<$Res> get fee;$RateCopyWith<$Res> get rate;

}
/// @nodoc
class _$TransferCopyWithImpl<$Res>
    implements $TransferCopyWith<$Res> {
  _$TransferCopyWithImpl(this._self, this._then);

  final Transfer _self;
  final $Res Function(Transfer) _then;

/// Create a copy of Transfer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? sourceAmount = null,Object? destAmount = null,Object? fee = null,Object? rate = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransferStatus,sourceAmount: null == sourceAmount ? _self.sourceAmount : sourceAmount // ignore: cast_nullable_to_non_nullable
as Money,destAmount: null == destAmount ? _self.destAmount : destAmount // ignore: cast_nullable_to_non_nullable
as Money,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as Money,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as Rate,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of Transfer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyCopyWith<$Res> get sourceAmount {
  
  return $MoneyCopyWith<$Res>(_self.sourceAmount, (value) {
    return _then(_self.copyWith(sourceAmount: value));
  });
}/// Create a copy of Transfer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyCopyWith<$Res> get destAmount {
  
  return $MoneyCopyWith<$Res>(_self.destAmount, (value) {
    return _then(_self.copyWith(destAmount: value));
  });
}/// Create a copy of Transfer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyCopyWith<$Res> get fee {
  
  return $MoneyCopyWith<$Res>(_self.fee, (value) {
    return _then(_self.copyWith(fee: value));
  });
}/// Create a copy of Transfer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RateCopyWith<$Res> get rate {
  
  return $RateCopyWith<$Res>(_self.rate, (value) {
    return _then(_self.copyWith(rate: value));
  });
}
}


/// Adds pattern-matching-related methods to [Transfer].
extension TransferPatterns on Transfer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Transfer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Transfer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Transfer value)  $default,){
final _that = this;
switch (_that) {
case _Transfer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Transfer value)?  $default,){
final _that = this;
switch (_that) {
case _Transfer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  TransferStatus status,  Money sourceAmount,  Money destAmount,  Money fee,  Rate rate,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Transfer() when $default != null:
return $default(_that.id,_that.status,_that.sourceAmount,_that.destAmount,_that.fee,_that.rate,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  TransferStatus status,  Money sourceAmount,  Money destAmount,  Money fee,  Rate rate,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Transfer():
return $default(_that.id,_that.status,_that.sourceAmount,_that.destAmount,_that.fee,_that.rate,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  TransferStatus status,  Money sourceAmount,  Money destAmount,  Money fee,  Rate rate,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Transfer() when $default != null:
return $default(_that.id,_that.status,_that.sourceAmount,_that.destAmount,_that.fee,_that.rate,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _Transfer implements Transfer {
  const _Transfer({required this.id, required this.status, required this.sourceAmount, required this.destAmount, required this.fee, required this.rate, required this.createdAt});
  

@override final  String id;
@override final  TransferStatus status;
@override final  Money sourceAmount;
@override final  Money destAmount;
@override final  Money fee;
@override final  Rate rate;
@override final  DateTime createdAt;

/// Create a copy of Transfer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferCopyWith<_Transfer> get copyWith => __$TransferCopyWithImpl<_Transfer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Transfer&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.sourceAmount, sourceAmount) || other.sourceAmount == sourceAmount)&&(identical(other.destAmount, destAmount) || other.destAmount == destAmount)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,status,sourceAmount,destAmount,fee,rate,createdAt);

@override
String toString() {
  return 'Transfer(id: $id, status: $status, sourceAmount: $sourceAmount, destAmount: $destAmount, fee: $fee, rate: $rate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TransferCopyWith<$Res> implements $TransferCopyWith<$Res> {
  factory _$TransferCopyWith(_Transfer value, $Res Function(_Transfer) _then) = __$TransferCopyWithImpl;
@override @useResult
$Res call({
 String id, TransferStatus status, Money sourceAmount, Money destAmount, Money fee, Rate rate, DateTime createdAt
});


@override $MoneyCopyWith<$Res> get sourceAmount;@override $MoneyCopyWith<$Res> get destAmount;@override $MoneyCopyWith<$Res> get fee;@override $RateCopyWith<$Res> get rate;

}
/// @nodoc
class __$TransferCopyWithImpl<$Res>
    implements _$TransferCopyWith<$Res> {
  __$TransferCopyWithImpl(this._self, this._then);

  final _Transfer _self;
  final $Res Function(_Transfer) _then;

/// Create a copy of Transfer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? sourceAmount = null,Object? destAmount = null,Object? fee = null,Object? rate = null,Object? createdAt = null,}) {
  return _then(_Transfer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransferStatus,sourceAmount: null == sourceAmount ? _self.sourceAmount : sourceAmount // ignore: cast_nullable_to_non_nullable
as Money,destAmount: null == destAmount ? _self.destAmount : destAmount // ignore: cast_nullable_to_non_nullable
as Money,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as Money,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as Rate,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of Transfer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyCopyWith<$Res> get sourceAmount {
  
  return $MoneyCopyWith<$Res>(_self.sourceAmount, (value) {
    return _then(_self.copyWith(sourceAmount: value));
  });
}/// Create a copy of Transfer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyCopyWith<$Res> get destAmount {
  
  return $MoneyCopyWith<$Res>(_self.destAmount, (value) {
    return _then(_self.copyWith(destAmount: value));
  });
}/// Create a copy of Transfer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyCopyWith<$Res> get fee {
  
  return $MoneyCopyWith<$Res>(_self.fee, (value) {
    return _then(_self.copyWith(fee: value));
  });
}/// Create a copy of Transfer
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

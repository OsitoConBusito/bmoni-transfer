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

 String get quoteId; MoneyDto get sourceAmount; MoneyDto get fee; FeeBreakdownDto get feeBreakdown; MoneyDto get destAmount; RateDto get rate; String get expiresAt;
/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteDtoCopyWith<QuoteDto> get copyWith => _$QuoteDtoCopyWithImpl<QuoteDto>(this as QuoteDto, _$identity);

  /// Serializes this QuoteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteDto&&(identical(other.quoteId, quoteId) || other.quoteId == quoteId)&&(identical(other.sourceAmount, sourceAmount) || other.sourceAmount == sourceAmount)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.feeBreakdown, feeBreakdown) || other.feeBreakdown == feeBreakdown)&&(identical(other.destAmount, destAmount) || other.destAmount == destAmount)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,quoteId,sourceAmount,fee,feeBreakdown,destAmount,rate,expiresAt);

@override
String toString() {
  return 'QuoteDto(quoteId: $quoteId, sourceAmount: $sourceAmount, fee: $fee, feeBreakdown: $feeBreakdown, destAmount: $destAmount, rate: $rate, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $QuoteDtoCopyWith<$Res>  {
  factory $QuoteDtoCopyWith(QuoteDto value, $Res Function(QuoteDto) _then) = _$QuoteDtoCopyWithImpl;
@useResult
$Res call({
 String quoteId, MoneyDto sourceAmount, MoneyDto fee, FeeBreakdownDto feeBreakdown, MoneyDto destAmount, RateDto rate, String expiresAt
});


$MoneyDtoCopyWith<$Res> get sourceAmount;$MoneyDtoCopyWith<$Res> get fee;$FeeBreakdownDtoCopyWith<$Res> get feeBreakdown;$MoneyDtoCopyWith<$Res> get destAmount;$RateDtoCopyWith<$Res> get rate;

}
/// @nodoc
class _$QuoteDtoCopyWithImpl<$Res>
    implements $QuoteDtoCopyWith<$Res> {
  _$QuoteDtoCopyWithImpl(this._self, this._then);

  final QuoteDto _self;
  final $Res Function(QuoteDto) _then;

/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quoteId = null,Object? sourceAmount = null,Object? fee = null,Object? feeBreakdown = null,Object? destAmount = null,Object? rate = null,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
quoteId: null == quoteId ? _self.quoteId : quoteId // ignore: cast_nullable_to_non_nullable
as String,sourceAmount: null == sourceAmount ? _self.sourceAmount : sourceAmount // ignore: cast_nullable_to_non_nullable
as MoneyDto,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as MoneyDto,feeBreakdown: null == feeBreakdown ? _self.feeBreakdown : feeBreakdown // ignore: cast_nullable_to_non_nullable
as FeeBreakdownDto,destAmount: null == destAmount ? _self.destAmount : destAmount // ignore: cast_nullable_to_non_nullable
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
$FeeBreakdownDtoCopyWith<$Res> get feeBreakdown {
  
  return $FeeBreakdownDtoCopyWith<$Res>(_self.feeBreakdown, (value) {
    return _then(_self.copyWith(feeBreakdown: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String quoteId,  MoneyDto sourceAmount,  MoneyDto fee,  FeeBreakdownDto feeBreakdown,  MoneyDto destAmount,  RateDto rate,  String expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteDto() when $default != null:
return $default(_that.quoteId,_that.sourceAmount,_that.fee,_that.feeBreakdown,_that.destAmount,_that.rate,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String quoteId,  MoneyDto sourceAmount,  MoneyDto fee,  FeeBreakdownDto feeBreakdown,  MoneyDto destAmount,  RateDto rate,  String expiresAt)  $default,) {final _that = this;
switch (_that) {
case _QuoteDto():
return $default(_that.quoteId,_that.sourceAmount,_that.fee,_that.feeBreakdown,_that.destAmount,_that.rate,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String quoteId,  MoneyDto sourceAmount,  MoneyDto fee,  FeeBreakdownDto feeBreakdown,  MoneyDto destAmount,  RateDto rate,  String expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _QuoteDto() when $default != null:
return $default(_that.quoteId,_that.sourceAmount,_that.fee,_that.feeBreakdown,_that.destAmount,_that.rate,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuoteDto implements QuoteDto {
  const _QuoteDto({required this.quoteId, required this.sourceAmount, required this.fee, required this.feeBreakdown, required this.destAmount, required this.rate, required this.expiresAt});
  factory _QuoteDto.fromJson(Map<String, dynamic> json) => _$QuoteDtoFromJson(json);

@override final  String quoteId;
@override final  MoneyDto sourceAmount;
@override final  MoneyDto fee;
@override final  FeeBreakdownDto feeBreakdown;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteDto&&(identical(other.quoteId, quoteId) || other.quoteId == quoteId)&&(identical(other.sourceAmount, sourceAmount) || other.sourceAmount == sourceAmount)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.feeBreakdown, feeBreakdown) || other.feeBreakdown == feeBreakdown)&&(identical(other.destAmount, destAmount) || other.destAmount == destAmount)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,quoteId,sourceAmount,fee,feeBreakdown,destAmount,rate,expiresAt);

@override
String toString() {
  return 'QuoteDto(quoteId: $quoteId, sourceAmount: $sourceAmount, fee: $fee, feeBreakdown: $feeBreakdown, destAmount: $destAmount, rate: $rate, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$QuoteDtoCopyWith<$Res> implements $QuoteDtoCopyWith<$Res> {
  factory _$QuoteDtoCopyWith(_QuoteDto value, $Res Function(_QuoteDto) _then) = __$QuoteDtoCopyWithImpl;
@override @useResult
$Res call({
 String quoteId, MoneyDto sourceAmount, MoneyDto fee, FeeBreakdownDto feeBreakdown, MoneyDto destAmount, RateDto rate, String expiresAt
});


@override $MoneyDtoCopyWith<$Res> get sourceAmount;@override $MoneyDtoCopyWith<$Res> get fee;@override $FeeBreakdownDtoCopyWith<$Res> get feeBreakdown;@override $MoneyDtoCopyWith<$Res> get destAmount;@override $RateDtoCopyWith<$Res> get rate;

}
/// @nodoc
class __$QuoteDtoCopyWithImpl<$Res>
    implements _$QuoteDtoCopyWith<$Res> {
  __$QuoteDtoCopyWithImpl(this._self, this._then);

  final _QuoteDto _self;
  final $Res Function(_QuoteDto) _then;

/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quoteId = null,Object? sourceAmount = null,Object? fee = null,Object? feeBreakdown = null,Object? destAmount = null,Object? rate = null,Object? expiresAt = null,}) {
  return _then(_QuoteDto(
quoteId: null == quoteId ? _self.quoteId : quoteId // ignore: cast_nullable_to_non_nullable
as String,sourceAmount: null == sourceAmount ? _self.sourceAmount : sourceAmount // ignore: cast_nullable_to_non_nullable
as MoneyDto,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as MoneyDto,feeBreakdown: null == feeBreakdown ? _self.feeBreakdown : feeBreakdown // ignore: cast_nullable_to_non_nullable
as FeeBreakdownDto,destAmount: null == destAmount ? _self.destAmount : destAmount // ignore: cast_nullable_to_non_nullable
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
$FeeBreakdownDtoCopyWith<$Res> get feeBreakdown {
  
  return $FeeBreakdownDtoCopyWith<$Res>(_self.feeBreakdown, (value) {
    return _then(_self.copyWith(feeBreakdown: value));
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


/// @nodoc
mixin _$FeeBreakdownDto {

 MoneyDto get fixed; MoneyDto get variable; MoneyDto get threshold; int get percentBasisPoints;
/// Create a copy of FeeBreakdownDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeeBreakdownDtoCopyWith<FeeBreakdownDto> get copyWith => _$FeeBreakdownDtoCopyWithImpl<FeeBreakdownDto>(this as FeeBreakdownDto, _$identity);

  /// Serializes this FeeBreakdownDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeeBreakdownDto&&(identical(other.fixed, fixed) || other.fixed == fixed)&&(identical(other.variable, variable) || other.variable == variable)&&(identical(other.threshold, threshold) || other.threshold == threshold)&&(identical(other.percentBasisPoints, percentBasisPoints) || other.percentBasisPoints == percentBasisPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fixed,variable,threshold,percentBasisPoints);

@override
String toString() {
  return 'FeeBreakdownDto(fixed: $fixed, variable: $variable, threshold: $threshold, percentBasisPoints: $percentBasisPoints)';
}


}

/// @nodoc
abstract mixin class $FeeBreakdownDtoCopyWith<$Res>  {
  factory $FeeBreakdownDtoCopyWith(FeeBreakdownDto value, $Res Function(FeeBreakdownDto) _then) = _$FeeBreakdownDtoCopyWithImpl;
@useResult
$Res call({
 MoneyDto fixed, MoneyDto variable, MoneyDto threshold, int percentBasisPoints
});


$MoneyDtoCopyWith<$Res> get fixed;$MoneyDtoCopyWith<$Res> get variable;$MoneyDtoCopyWith<$Res> get threshold;

}
/// @nodoc
class _$FeeBreakdownDtoCopyWithImpl<$Res>
    implements $FeeBreakdownDtoCopyWith<$Res> {
  _$FeeBreakdownDtoCopyWithImpl(this._self, this._then);

  final FeeBreakdownDto _self;
  final $Res Function(FeeBreakdownDto) _then;

/// Create a copy of FeeBreakdownDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fixed = null,Object? variable = null,Object? threshold = null,Object? percentBasisPoints = null,}) {
  return _then(_self.copyWith(
fixed: null == fixed ? _self.fixed : fixed // ignore: cast_nullable_to_non_nullable
as MoneyDto,variable: null == variable ? _self.variable : variable // ignore: cast_nullable_to_non_nullable
as MoneyDto,threshold: null == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as MoneyDto,percentBasisPoints: null == percentBasisPoints ? _self.percentBasisPoints : percentBasisPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of FeeBreakdownDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyDtoCopyWith<$Res> get fixed {
  
  return $MoneyDtoCopyWith<$Res>(_self.fixed, (value) {
    return _then(_self.copyWith(fixed: value));
  });
}/// Create a copy of FeeBreakdownDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyDtoCopyWith<$Res> get variable {
  
  return $MoneyDtoCopyWith<$Res>(_self.variable, (value) {
    return _then(_self.copyWith(variable: value));
  });
}/// Create a copy of FeeBreakdownDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyDtoCopyWith<$Res> get threshold {
  
  return $MoneyDtoCopyWith<$Res>(_self.threshold, (value) {
    return _then(_self.copyWith(threshold: value));
  });
}
}


/// Adds pattern-matching-related methods to [FeeBreakdownDto].
extension FeeBreakdownDtoPatterns on FeeBreakdownDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeeBreakdownDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeeBreakdownDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeeBreakdownDto value)  $default,){
final _that = this;
switch (_that) {
case _FeeBreakdownDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeeBreakdownDto value)?  $default,){
final _that = this;
switch (_that) {
case _FeeBreakdownDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MoneyDto fixed,  MoneyDto variable,  MoneyDto threshold,  int percentBasisPoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeeBreakdownDto() when $default != null:
return $default(_that.fixed,_that.variable,_that.threshold,_that.percentBasisPoints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MoneyDto fixed,  MoneyDto variable,  MoneyDto threshold,  int percentBasisPoints)  $default,) {final _that = this;
switch (_that) {
case _FeeBreakdownDto():
return $default(_that.fixed,_that.variable,_that.threshold,_that.percentBasisPoints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MoneyDto fixed,  MoneyDto variable,  MoneyDto threshold,  int percentBasisPoints)?  $default,) {final _that = this;
switch (_that) {
case _FeeBreakdownDto() when $default != null:
return $default(_that.fixed,_that.variable,_that.threshold,_that.percentBasisPoints);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeeBreakdownDto implements FeeBreakdownDto {
  const _FeeBreakdownDto({required this.fixed, required this.variable, required this.threshold, required this.percentBasisPoints});
  factory _FeeBreakdownDto.fromJson(Map<String, dynamic> json) => _$FeeBreakdownDtoFromJson(json);

@override final  MoneyDto fixed;
@override final  MoneyDto variable;
@override final  MoneyDto threshold;
@override final  int percentBasisPoints;

/// Create a copy of FeeBreakdownDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeeBreakdownDtoCopyWith<_FeeBreakdownDto> get copyWith => __$FeeBreakdownDtoCopyWithImpl<_FeeBreakdownDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeeBreakdownDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeeBreakdownDto&&(identical(other.fixed, fixed) || other.fixed == fixed)&&(identical(other.variable, variable) || other.variable == variable)&&(identical(other.threshold, threshold) || other.threshold == threshold)&&(identical(other.percentBasisPoints, percentBasisPoints) || other.percentBasisPoints == percentBasisPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fixed,variable,threshold,percentBasisPoints);

@override
String toString() {
  return 'FeeBreakdownDto(fixed: $fixed, variable: $variable, threshold: $threshold, percentBasisPoints: $percentBasisPoints)';
}


}

/// @nodoc
abstract mixin class _$FeeBreakdownDtoCopyWith<$Res> implements $FeeBreakdownDtoCopyWith<$Res> {
  factory _$FeeBreakdownDtoCopyWith(_FeeBreakdownDto value, $Res Function(_FeeBreakdownDto) _then) = __$FeeBreakdownDtoCopyWithImpl;
@override @useResult
$Res call({
 MoneyDto fixed, MoneyDto variable, MoneyDto threshold, int percentBasisPoints
});


@override $MoneyDtoCopyWith<$Res> get fixed;@override $MoneyDtoCopyWith<$Res> get variable;@override $MoneyDtoCopyWith<$Res> get threshold;

}
/// @nodoc
class __$FeeBreakdownDtoCopyWithImpl<$Res>
    implements _$FeeBreakdownDtoCopyWith<$Res> {
  __$FeeBreakdownDtoCopyWithImpl(this._self, this._then);

  final _FeeBreakdownDto _self;
  final $Res Function(_FeeBreakdownDto) _then;

/// Create a copy of FeeBreakdownDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fixed = null,Object? variable = null,Object? threshold = null,Object? percentBasisPoints = null,}) {
  return _then(_FeeBreakdownDto(
fixed: null == fixed ? _self.fixed : fixed // ignore: cast_nullable_to_non_nullable
as MoneyDto,variable: null == variable ? _self.variable : variable // ignore: cast_nullable_to_non_nullable
as MoneyDto,threshold: null == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as MoneyDto,percentBasisPoints: null == percentBasisPoints ? _self.percentBasisPoints : percentBasisPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of FeeBreakdownDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyDtoCopyWith<$Res> get fixed {
  
  return $MoneyDtoCopyWith<$Res>(_self.fixed, (value) {
    return _then(_self.copyWith(fixed: value));
  });
}/// Create a copy of FeeBreakdownDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyDtoCopyWith<$Res> get variable {
  
  return $MoneyDtoCopyWith<$Res>(_self.variable, (value) {
    return _then(_self.copyWith(variable: value));
  });
}/// Create a copy of FeeBreakdownDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyDtoCopyWith<$Res> get threshold {
  
  return $MoneyDtoCopyWith<$Res>(_self.threshold, (value) {
    return _then(_self.copyWith(threshold: value));
  });
}
}

// dart format on

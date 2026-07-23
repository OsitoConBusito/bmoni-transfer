// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fee_breakdown.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeeBreakdown {

 Money get fixed; Money get variable; Money get threshold; int get percentBasisPoints;
/// Create a copy of FeeBreakdown
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeeBreakdownCopyWith<FeeBreakdown> get copyWith => _$FeeBreakdownCopyWithImpl<FeeBreakdown>(this as FeeBreakdown, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeeBreakdown&&(identical(other.fixed, fixed) || other.fixed == fixed)&&(identical(other.variable, variable) || other.variable == variable)&&(identical(other.threshold, threshold) || other.threshold == threshold)&&(identical(other.percentBasisPoints, percentBasisPoints) || other.percentBasisPoints == percentBasisPoints));
}


@override
int get hashCode => Object.hash(runtimeType,fixed,variable,threshold,percentBasisPoints);

@override
String toString() {
  return 'FeeBreakdown(fixed: $fixed, variable: $variable, threshold: $threshold, percentBasisPoints: $percentBasisPoints)';
}


}

/// @nodoc
abstract mixin class $FeeBreakdownCopyWith<$Res>  {
  factory $FeeBreakdownCopyWith(FeeBreakdown value, $Res Function(FeeBreakdown) _then) = _$FeeBreakdownCopyWithImpl;
@useResult
$Res call({
 Money fixed, Money variable, Money threshold, int percentBasisPoints
});


$MoneyCopyWith<$Res> get fixed;$MoneyCopyWith<$Res> get variable;$MoneyCopyWith<$Res> get threshold;

}
/// @nodoc
class _$FeeBreakdownCopyWithImpl<$Res>
    implements $FeeBreakdownCopyWith<$Res> {
  _$FeeBreakdownCopyWithImpl(this._self, this._then);

  final FeeBreakdown _self;
  final $Res Function(FeeBreakdown) _then;

/// Create a copy of FeeBreakdown
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fixed = null,Object? variable = null,Object? threshold = null,Object? percentBasisPoints = null,}) {
  return _then(_self.copyWith(
fixed: null == fixed ? _self.fixed : fixed // ignore: cast_nullable_to_non_nullable
as Money,variable: null == variable ? _self.variable : variable // ignore: cast_nullable_to_non_nullable
as Money,threshold: null == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as Money,percentBasisPoints: null == percentBasisPoints ? _self.percentBasisPoints : percentBasisPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of FeeBreakdown
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyCopyWith<$Res> get fixed {
  
  return $MoneyCopyWith<$Res>(_self.fixed, (value) {
    return _then(_self.copyWith(fixed: value));
  });
}/// Create a copy of FeeBreakdown
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyCopyWith<$Res> get variable {
  
  return $MoneyCopyWith<$Res>(_self.variable, (value) {
    return _then(_self.copyWith(variable: value));
  });
}/// Create a copy of FeeBreakdown
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyCopyWith<$Res> get threshold {
  
  return $MoneyCopyWith<$Res>(_self.threshold, (value) {
    return _then(_self.copyWith(threshold: value));
  });
}
}


/// Adds pattern-matching-related methods to [FeeBreakdown].
extension FeeBreakdownPatterns on FeeBreakdown {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeeBreakdown value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeeBreakdown() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeeBreakdown value)  $default,){
final _that = this;
switch (_that) {
case _FeeBreakdown():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeeBreakdown value)?  $default,){
final _that = this;
switch (_that) {
case _FeeBreakdown() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Money fixed,  Money variable,  Money threshold,  int percentBasisPoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeeBreakdown() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Money fixed,  Money variable,  Money threshold,  int percentBasisPoints)  $default,) {final _that = this;
switch (_that) {
case _FeeBreakdown():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Money fixed,  Money variable,  Money threshold,  int percentBasisPoints)?  $default,) {final _that = this;
switch (_that) {
case _FeeBreakdown() when $default != null:
return $default(_that.fixed,_that.variable,_that.threshold,_that.percentBasisPoints);case _:
  return null;

}
}

}

/// @nodoc


class _FeeBreakdown extends FeeBreakdown {
  const _FeeBreakdown({required this.fixed, required this.variable, required this.threshold, required this.percentBasisPoints}): super._();
  

@override final  Money fixed;
@override final  Money variable;
@override final  Money threshold;
@override final  int percentBasisPoints;

/// Create a copy of FeeBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeeBreakdownCopyWith<_FeeBreakdown> get copyWith => __$FeeBreakdownCopyWithImpl<_FeeBreakdown>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeeBreakdown&&(identical(other.fixed, fixed) || other.fixed == fixed)&&(identical(other.variable, variable) || other.variable == variable)&&(identical(other.threshold, threshold) || other.threshold == threshold)&&(identical(other.percentBasisPoints, percentBasisPoints) || other.percentBasisPoints == percentBasisPoints));
}


@override
int get hashCode => Object.hash(runtimeType,fixed,variable,threshold,percentBasisPoints);

@override
String toString() {
  return 'FeeBreakdown(fixed: $fixed, variable: $variable, threshold: $threshold, percentBasisPoints: $percentBasisPoints)';
}


}

/// @nodoc
abstract mixin class _$FeeBreakdownCopyWith<$Res> implements $FeeBreakdownCopyWith<$Res> {
  factory _$FeeBreakdownCopyWith(_FeeBreakdown value, $Res Function(_FeeBreakdown) _then) = __$FeeBreakdownCopyWithImpl;
@override @useResult
$Res call({
 Money fixed, Money variable, Money threshold, int percentBasisPoints
});


@override $MoneyCopyWith<$Res> get fixed;@override $MoneyCopyWith<$Res> get variable;@override $MoneyCopyWith<$Res> get threshold;

}
/// @nodoc
class __$FeeBreakdownCopyWithImpl<$Res>
    implements _$FeeBreakdownCopyWith<$Res> {
  __$FeeBreakdownCopyWithImpl(this._self, this._then);

  final _FeeBreakdown _self;
  final $Res Function(_FeeBreakdown) _then;

/// Create a copy of FeeBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fixed = null,Object? variable = null,Object? threshold = null,Object? percentBasisPoints = null,}) {
  return _then(_FeeBreakdown(
fixed: null == fixed ? _self.fixed : fixed // ignore: cast_nullable_to_non_nullable
as Money,variable: null == variable ? _self.variable : variable // ignore: cast_nullable_to_non_nullable
as Money,threshold: null == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as Money,percentBasisPoints: null == percentBasisPoints ? _self.percentBasisPoints : percentBasisPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of FeeBreakdown
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyCopyWith<$Res> get fixed {
  
  return $MoneyCopyWith<$Res>(_self.fixed, (value) {
    return _then(_self.copyWith(fixed: value));
  });
}/// Create a copy of FeeBreakdown
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyCopyWith<$Res> get variable {
  
  return $MoneyCopyWith<$Res>(_self.variable, (value) {
    return _then(_self.copyWith(variable: value));
  });
}/// Create a copy of FeeBreakdown
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoneyCopyWith<$Res> get threshold {
  
  return $MoneyCopyWith<$Res>(_self.threshold, (value) {
    return _then(_self.copyWith(threshold: value));
  });
}
}

// dart format on

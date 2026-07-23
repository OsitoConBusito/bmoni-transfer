// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MoneyDto _$MoneyDtoFromJson(Map<String, dynamic> json) => _MoneyDto(
  minorUnits: (json['minorUnits'] as num).toInt(),
  currency: json['currency'] as String,
);

Map<String, dynamic> _$MoneyDtoToJson(_MoneyDto instance) => <String, dynamic>{
  'minorUnits': instance.minorUnits,
  'currency': instance.currency,
};

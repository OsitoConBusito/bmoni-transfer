// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RateDto _$RateDtoFromJson(Map<String, dynamic> json) => _RateDto(
  value: json['value'] as String,
  source: json['source'] as String,
  asOf: json['asOf'] as String,
);

Map<String, dynamic> _$RateDtoToJson(_RateDto instance) => <String, dynamic>{
  'value': instance.value,
  'source': instance.source,
  'asOf': instance.asOf,
};

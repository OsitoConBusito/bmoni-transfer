// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuoteDto _$QuoteDtoFromJson(Map<String, dynamic> json) => _QuoteDto(
  quoteId: json['quoteId'] as String,
  sourceAmount: MoneyDto.fromJson(json['sourceAmount'] as Map<String, dynamic>),
  fee: MoneyDto.fromJson(json['fee'] as Map<String, dynamic>),
  destAmount: MoneyDto.fromJson(json['destAmount'] as Map<String, dynamic>),
  rate: RateDto.fromJson(json['rate'] as Map<String, dynamic>),
  expiresAt: json['expiresAt'] as String,
);

Map<String, dynamic> _$QuoteDtoToJson(_QuoteDto instance) => <String, dynamic>{
  'quoteId': instance.quoteId,
  'sourceAmount': instance.sourceAmount,
  'fee': instance.fee,
  'destAmount': instance.destAmount,
  'rate': instance.rate,
  'expiresAt': instance.expiresAt,
};

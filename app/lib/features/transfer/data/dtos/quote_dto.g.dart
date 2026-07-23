// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuoteDto _$QuoteDtoFromJson(Map<String, dynamic> json) => _QuoteDto(
  quoteId: json['quoteId'] as String,
  sourceAmount: MoneyDto.fromJson(json['sourceAmount'] as Map<String, dynamic>),
  fee: MoneyDto.fromJson(json['fee'] as Map<String, dynamic>),
  feeBreakdown: FeeBreakdownDto.fromJson(
    json['feeBreakdown'] as Map<String, dynamic>,
  ),
  destAmount: MoneyDto.fromJson(json['destAmount'] as Map<String, dynamic>),
  rate: RateDto.fromJson(json['rate'] as Map<String, dynamic>),
  createdAt: json['createdAt'] as String,
  expiresAt: json['expiresAt'] as String,
);

Map<String, dynamic> _$QuoteDtoToJson(_QuoteDto instance) => <String, dynamic>{
  'quoteId': instance.quoteId,
  'sourceAmount': instance.sourceAmount,
  'fee': instance.fee,
  'feeBreakdown': instance.feeBreakdown,
  'destAmount': instance.destAmount,
  'rate': instance.rate,
  'createdAt': instance.createdAt,
  'expiresAt': instance.expiresAt,
};

_FeeBreakdownDto _$FeeBreakdownDtoFromJson(Map<String, dynamic> json) =>
    _FeeBreakdownDto(
      fixed: MoneyDto.fromJson(json['fixed'] as Map<String, dynamic>),
      variable: MoneyDto.fromJson(json['variable'] as Map<String, dynamic>),
      threshold: MoneyDto.fromJson(json['threshold'] as Map<String, dynamic>),
      percentBasisPoints: (json['percentBasisPoints'] as num).toInt(),
    );

Map<String, dynamic> _$FeeBreakdownDtoToJson(_FeeBreakdownDto instance) =>
    <String, dynamic>{
      'fixed': instance.fixed,
      'variable': instance.variable,
      'threshold': instance.threshold,
      'percentBasisPoints': instance.percentBasisPoints,
    };

import 'package:bmoni_transfer/features/transfer/data/dtos/money_dto.dart';
import 'package:bmoni_transfer/features/transfer/data/dtos/rate_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_dto.freezed.dart';
part 'quote_dto.g.dart';

@freezed
abstract class QuoteDto with _$QuoteDto {
  const factory QuoteDto({
    required String quoteId,
    required MoneyDto sourceAmount,
    required MoneyDto fee,
    required FeeBreakdownDto feeBreakdown,
    required MoneyDto destAmount,
    required RateDto rate,
    required String expiresAt,
  }) = _QuoteDto;

  factory QuoteDto.fromJson(Map<String, dynamic> json) =>
      _$QuoteDtoFromJson(json);
}

@freezed
abstract class FeeBreakdownDto with _$FeeBreakdownDto {
  const factory FeeBreakdownDto({
    required MoneyDto fixed,
    required MoneyDto variable,
    required MoneyDto threshold,
    required int percentBasisPoints,
  }) = _FeeBreakdownDto;

  factory FeeBreakdownDto.fromJson(Map<String, dynamic> json) =>
      _$FeeBreakdownDtoFromJson(json);
}

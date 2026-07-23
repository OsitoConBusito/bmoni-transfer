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
    required MoneyDto destAmount,
    required RateDto rate,
    required String expiresAt,
  }) = _QuoteDto;

  factory QuoteDto.fromJson(Map<String, dynamic> json) =>
      _$QuoteDtoFromJson(json);
}

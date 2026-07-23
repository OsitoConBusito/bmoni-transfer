import 'package:bmoni_transfer/core/money/currency.dart';
import 'package:bmoni_transfer/core/money/money.dart';
import 'package:bmoni_transfer/features/transfer/data/dtos/money_dto.dart';
import 'package:bmoni_transfer/features/transfer/data/dtos/quote_dto.dart';
import 'package:bmoni_transfer/features/transfer/data/dtos/rate_dto.dart';
import 'package:bmoni_transfer/features/transfer/data/dtos/transfer_dto.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/fee_breakdown.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/quote.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/rate.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer_status.dart';

extension MoneyDtoMapper on MoneyDto {
  Money toDomain() =>
      Money(minorUnits: minorUnits, currency: Currency.fromCode(currency));
}

extension RateDtoMapper on RateDto {
  Rate toDomain() => Rate(value: value, source: source, asOf: asOf);
}

extension QuoteDtoMapper on QuoteDto {
  Quote toDomain() => Quote(
    id: quoteId,
    sourceAmount: sourceAmount.toDomain(),
    fee: fee.toDomain(),
    feeBreakdown: feeBreakdown.toDomain(),
    destAmount: destAmount.toDomain(),
    rate: rate.toDomain(),
    createdAt: DateTime.parse(createdAt),
    expiresAt: DateTime.parse(expiresAt),
  );
}

extension FeeBreakdownDtoMapper on FeeBreakdownDto {
  FeeBreakdown toDomain() => FeeBreakdown(
    fixed: fixed.toDomain(),
    variable: variable.toDomain(),
    threshold: threshold.toDomain(),
    percentBasisPoints: percentBasisPoints,
  );
}

extension TransferDtoMapper on TransferDto {
  Transfer toDomain() => Transfer(
    id: transferId,
    status: TransferStatus.fromWire(status),
    sourceAmount: sourceAmount.toDomain(),
    destAmount: destAmount.toDomain(),
    fee: fee.toDomain(),
    rate: rate.toDomain(),
    createdAt: DateTime.parse(createdAt),
  );
}

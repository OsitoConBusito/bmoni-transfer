import 'package:bmoni_transfer/features/transfer/data/dtos/money_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_dto.freezed.dart';
part 'transfer_dto.g.dart';

@freezed
abstract class TransferDto with _$TransferDto {
  const factory TransferDto({
    required String transferId,
    required String status,
    required String quoteId,
    required MoneyDto sourceAmount,
    required MoneyDto destAmount,
    required MoneyDto fee,
    required String createdAt,
  }) = _TransferDto;

  factory TransferDto.fromJson(Map<String, dynamic> json) =>
      _$TransferDtoFromJson(json);
}

import 'package:bmoni_transfer/core/money/money.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer.freezed.dart';

@freezed
abstract class Transfer with _$Transfer {
  const factory Transfer({
    required String id,
    required TransferStatus status,
    required Money sourceAmount,
    required Money destAmount,
    required Money fee,
    required DateTime createdAt,
  }) = _Transfer;
}

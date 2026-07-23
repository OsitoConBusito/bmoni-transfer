import 'package:bmoni_transfer/core/result/result.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer.dart';
import 'package:bmoni_transfer/features/transfer/domain/transfer_repository.dart';

class CreateTransfer {
  const CreateTransfer(this._repository);

  final TransferRepository _repository;

  Future<Result<Transfer>> call({
    required String quoteId,
    required String idempotencyKey,
  }) {
    return _repository.createTransfer(
      quoteId: quoteId,
      idempotencyKey: idempotencyKey,
    );
  }
}

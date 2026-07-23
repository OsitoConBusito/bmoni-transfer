import 'package:bmoni_transfer/core/result/result.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/quote.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer.dart';

abstract interface class TransferRepository {
  Future<Result<Quote>> getQuote(String amount);

  Future<Result<Transfer>> createTransfer({
    required String quoteId,
    required String idempotencyKey,
  });
}

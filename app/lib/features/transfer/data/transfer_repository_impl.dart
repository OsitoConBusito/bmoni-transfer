import 'package:bmoni_transfer/core/result/result.dart';
import 'package:bmoni_transfer/features/transfer/data/datasources/transfer_remote_datasource.dart';
import 'package:bmoni_transfer/features/transfer/data/mappers/transfer_mappers.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/quote.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer.dart';
import 'package:bmoni_transfer/features/transfer/domain/transfer_repository.dart';

class TransferRepositoryImpl implements TransferRepository {
  const TransferRepositoryImpl(this._datasource);

  final TransferRemoteDatasource _datasource;

  @override
  Future<Result<Quote>> getQuote(String amount) async {
    final result = await _datasource.getQuote(amount);
    return switch (result) {
      Ok(:final value) => Ok(value.toDomain()),
      Err(:final failure) => Err(failure),
    };
  }

  @override
  Future<Result<Transfer>> createTransfer({
    required String quoteId,
    required String idempotencyKey,
  }) async {
    final result = await _datasource.createTransfer(
      quoteId: quoteId,
      idempotencyKey: idempotencyKey,
    );
    return switch (result) {
      Ok(:final value) => Ok(value.toDomain()),
      Err(:final failure) => Err(failure),
    };
  }
}

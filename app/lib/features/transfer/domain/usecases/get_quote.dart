import 'package:bmoni_transfer/core/result/result.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/quote.dart';
import 'package:bmoni_transfer/features/transfer/domain/transfer_repository.dart';

class GetQuote {
  const GetQuote(this._repository);

  final TransferRepository _repository;

  Future<Result<Quote>> call(String amount) => _repository.getQuote(amount);
}

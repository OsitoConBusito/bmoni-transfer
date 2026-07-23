import 'package:bmoni_transfer/features/transfer/data/datasources/transfer_remote_datasource.dart';
import 'package:bmoni_transfer/features/transfer/data/transfer_repository_impl.dart';
import 'package:bmoni_transfer/features/transfer/domain/transfer_repository.dart';
import 'package:bmoni_transfer/features/transfer/domain/usecases/create_transfer.dart';
import 'package:bmoni_transfer/features/transfer/domain/usecases/get_quote.dart';
import 'package:bmoni_transfer/shared/network/dio_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transfer_providers.g.dart';

@riverpod
TransferRemoteDatasource transferRemoteDatasource(Ref ref) =>
    TransferRemoteDatasource(ref.watch(dioProvider));

@riverpod
TransferRepository transferRepository(Ref ref) =>
    TransferRepositoryImpl(ref.watch(transferRemoteDatasourceProvider));

@riverpod
GetQuote getQuoteUseCase(Ref ref) =>
    GetQuote(ref.watch(transferRepositoryProvider));

@riverpod
CreateTransfer createTransferUseCase(Ref ref) =>
    CreateTransfer(ref.watch(transferRepositoryProvider));

@riverpod
Duration quoteDebounce(Ref ref) => const Duration(milliseconds: 400);

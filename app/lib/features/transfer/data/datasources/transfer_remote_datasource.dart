import 'package:bmoni_transfer/core/error/failure.dart';
import 'package:bmoni_transfer/core/result/result.dart';
import 'package:bmoni_transfer/features/transfer/data/datasources/dio_error_mapper.dart';
import 'package:bmoni_transfer/features/transfer/data/datasources/transfer_api.dart';
import 'package:bmoni_transfer/features/transfer/data/dtos/quote_dto.dart';
import 'package:bmoni_transfer/features/transfer/data/dtos/transfer_dto.dart';
import 'package:bmoni_transfer/features/transfer/data/mappers/transfer_mappers.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/quote.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer.dart';
import 'package:dio/dio.dart';

class TransferRemoteDatasource {
  const TransferRemoteDatasource(this._dio);

  final Dio _dio;

  Future<Result<Quote>> getQuote(String amount) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        TransferApi.quotePath,
        queryParameters: {TransferApi.amountParam: amount},
      );
      return Ok(QuoteDto.fromJson(response.data!).toDomain());
    } on DioException catch (error) {
      return Err(mapDioError(error));
    } on Object {
      return const Err(UnexpectedFailure());
    }
  }

  Future<Result<Transfer>> createTransfer({
    required String quoteId,
    required String idempotencyKey,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        TransferApi.transfersPath,
        data: {TransferApi.quoteIdField: quoteId},
        options: Options(
          headers: {TransferApi.idempotencyKeyHeader: idempotencyKey},
        ),
      );
      return Ok(TransferDto.fromJson(response.data!).toDomain());
    } on DioException catch (error) {
      return Err(mapDioError(error));
    } on Object {
      return const Err(UnexpectedFailure());
    }
  }
}

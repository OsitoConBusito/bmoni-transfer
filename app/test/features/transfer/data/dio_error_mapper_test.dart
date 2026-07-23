import 'package:bmoni_transfer/core/error/failure.dart';
import 'package:bmoni_transfer/features/transfer/data/datasources/dio_error_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

DioException _dioError(int? status, {Object? data}) {
  final options = RequestOptions(path: '/x');
  return DioException(
    requestOptions: options,
    response: status == null
        ? null
        : Response<Object?>(
            requestOptions: options,
            statusCode: status,
            data: data,
          ),
  );
}

Object _envelope(String code, {String? field}) {
  final error = <String, Object>{'code': code};
  if (field != null) {
    error['field'] = field;
  }
  return {'error': error};
}

void main() {
  group('mapDioError', () {
    test('given no response, then NetworkFailure', () {
      expect(mapDioError(_dioError(null)), isA<NetworkFailure>());
    });

    test('given 400, then ValidationFailure with code and field', () {
      final failure = mapDioError(
        _dioError(400, data: _envelope('AMOUNT_TOO_LOW', field: 'amount')),
      );
      expect(failure, isA<ValidationFailure>());
      expect((failure as ValidationFailure).code, 'AMOUNT_TOO_LOW');
      expect(failure.field, 'amount');
    });

    test('given 404, then NotFoundFailure with code', () {
      final failure = mapDioError(
        _dioError(404, data: _envelope('QUOTE_NOT_FOUND')),
      );
      expect(failure, isA<NotFoundFailure>());
      expect((failure as NotFoundFailure).code, 'QUOTE_NOT_FOUND');
    });

    test('given 409, then ConflictFailure with code', () {
      final failure = mapDioError(
        _dioError(409, data: _envelope('QUOTE_EXPIRED')),
      );
      expect(failure, isA<ConflictFailure>());
      expect((failure as ConflictFailure).code, 'QUOTE_EXPIRED');
    });

    test('given 503, then RateUnavailableFailure', () {
      expect(mapDioError(_dioError(503)), isA<RateUnavailableFailure>());
    });

    test('given 500, then UnexpectedFailure', () {
      expect(mapDioError(_dioError(500)), isA<UnexpectedFailure>());
    });
  });
}

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
    test('given no response, when mapDioError, then NetworkFailure', () {
      expect(mapDioError(_dioError(null)), isA<NetworkFailure>());
    });

    test('given a 400, when mapDioError, then ValidationFailure', () {
      final failure = mapDioError(
        _dioError(400, data: _envelope('AMOUNT_TOO_LOW', field: 'amount')),
      );
      expect(failure, isA<ValidationFailure>());
      expect((failure as ValidationFailure).code, 'AMOUNT_TOO_LOW');
      expect(failure.field, 'amount');
    });

    test('given a 404, when mapDioError, then NotFoundFailure', () {
      final failure = mapDioError(
        _dioError(404, data: _envelope('QUOTE_NOT_FOUND')),
      );
      expect(failure, isA<NotFoundFailure>());
      expect((failure as NotFoundFailure).code, 'QUOTE_NOT_FOUND');
    });

    test('given a 409, when mapDioError, then ConflictFailure', () {
      final failure = mapDioError(
        _dioError(409, data: _envelope('QUOTE_EXPIRED')),
      );
      expect(failure, isA<ConflictFailure>());
      expect((failure as ConflictFailure).code, 'QUOTE_EXPIRED');
    });

    test('given a 503, when mapDioError, then RateUnavailableFailure', () {
      expect(mapDioError(_dioError(503)), isA<RateUnavailableFailure>());
    });

    test('given a 500, when mapDioError, then UnexpectedFailure', () {
      expect(mapDioError(_dioError(500)), isA<UnexpectedFailure>());
    });
  });
}

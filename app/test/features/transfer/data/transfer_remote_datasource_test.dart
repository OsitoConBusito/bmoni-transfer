import 'package:bmoni_transfer/core/error/failure.dart';
import 'package:bmoni_transfer/core/result/result.dart';
import 'package:bmoni_transfer/features/transfer/data/datasources/transfer_remote_datasource.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/quote.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDio extends Mock implements Dio {}

final _options = RequestOptions(path: '/quote');

Map<String, dynamic> _quoteBody({String destCurrency = 'USD'}) => {
  'quoteId': 'q1',
  'sourceAmount': {'minorUnits': 100000, 'currency': 'MXN'},
  'fee': {'minorUnits': 2000, 'currency': 'MXN'},
  'destAmount': {'minorUnits': 5624, 'currency': destCurrency},
  'rate': {'value': '0.05739', 'source': 'stub', 'asOf': '2026-07-22'},
  'expiresAt': '2026-07-22T19:01:00.000Z',
};

void main() {
  late _MockDio dio;
  late TransferRemoteDatasource datasource;

  setUp(() {
    dio = _MockDio();
    datasource = TransferRemoteDatasource(dio);
  });

  void stubGet(Future<Response<Map<String, dynamic>>> Function() answer) {
    when(
      () => dio.get<Map<String, dynamic>>(
        any(),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer((_) => answer());
  }

  Response<Map<String, dynamic>> ok(Map<String, dynamic> data) =>
      Response(requestOptions: _options, statusCode: 200, data: data);

  test('given a valid body, when getQuote, then Ok<Quote>', () async {
    stubGet(() async => ok(_quoteBody()));

    final result = await datasource.getQuote('1000');

    expect(result, isA<Ok<Quote>>());
    expect((result as Ok<Quote>).value.destAmount.minorUnits, 5624);
  });

  test('given unknown currency 2xx, when getQuote, then Unexpected', () async {
    stubGet(() async => ok(_quoteBody(destCurrency: 'XXX')));

    final result = await datasource.getQuote('1000');

    expect(result, isA<Err<Quote>>());
    expect((result as Err<Quote>).failure, isA<UnexpectedFailure>());
  });

  test('given a 400, when getQuote, then ValidationFailure', () async {
    stubGet(
      () async => throw DioException(
        requestOptions: _options,
        response: Response(
          requestOptions: _options,
          statusCode: 400,
          data: {
            'error': {'code': 'AMOUNT_TOO_LOW', 'field': 'amount'},
          },
        ),
      ),
    );

    final result = await datasource.getQuote('5');

    expect(result, isA<Err<Quote>>());
    expect((result as Err<Quote>).failure, isA<ValidationFailure>());
  });
}

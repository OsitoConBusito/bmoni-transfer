import 'package:freezed_annotation/freezed_annotation.dart';

part 'rate.freezed.dart';

@freezed
abstract class Rate with _$Rate {
  const factory Rate({
    required String value,
    required String source,
    required String asOf,
  }) = _Rate;
}

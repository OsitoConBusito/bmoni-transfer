import 'package:freezed_annotation/freezed_annotation.dart';

part 'money_dto.freezed.dart';
part 'money_dto.g.dart';

@freezed
abstract class MoneyDto with _$MoneyDto {
  const factory MoneyDto({
    required int minorUnits,
    required String currency,
  }) = _MoneyDto;

  factory MoneyDto.fromJson(Map<String, dynamic> json) =>
      _$MoneyDtoFromJson(json);
}

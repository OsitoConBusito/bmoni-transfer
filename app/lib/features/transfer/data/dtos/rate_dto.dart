import 'package:freezed_annotation/freezed_annotation.dart';

part 'rate_dto.freezed.dart';
part 'rate_dto.g.dart';

@freezed
abstract class RateDto with _$RateDto {
  const factory RateDto({
    required String value,
    required String source,
    required String asOf,
  }) = _RateDto;

  factory RateDto.fromJson(Map<String, dynamic> json) =>
      _$RateDtoFromJson(json);
}

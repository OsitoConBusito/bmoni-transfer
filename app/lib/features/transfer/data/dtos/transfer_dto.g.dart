// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransferDto _$TransferDtoFromJson(Map<String, dynamic> json) => _TransferDto(
  transferId: json['transferId'] as String,
  status: json['status'] as String,
  quoteId: json['quoteId'] as String,
  sourceAmount: MoneyDto.fromJson(json['sourceAmount'] as Map<String, dynamic>),
  destAmount: MoneyDto.fromJson(json['destAmount'] as Map<String, dynamic>),
  fee: MoneyDto.fromJson(json['fee'] as Map<String, dynamic>),
  createdAt: json['createdAt'] as String,
);

Map<String, dynamic> _$TransferDtoToJson(_TransferDto instance) =>
    <String, dynamic>{
      'transferId': instance.transferId,
      'status': instance.status,
      'quoteId': instance.quoteId,
      'sourceAmount': instance.sourceAmount,
      'destAmount': instance.destAmount,
      'fee': instance.fee,
      'createdAt': instance.createdAt,
    };

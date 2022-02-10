// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deduction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deduction _$DeductionFromJson(Map<String, dynamic> json) => Deduction(
      amount: json['amount'] as int,
      type: json['type'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$DeductionToJson(Deduction instance) => <String, dynamic>{
      'amount': instance.amount,
      'type': instance.type,
      'reason': instance.reason,
    };

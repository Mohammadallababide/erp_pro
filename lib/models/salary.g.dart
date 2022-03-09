// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Salary _$SalaryFromJson(Map<String, dynamic> json) => Salary(
      id: json['id'] as int?,
      receiptId: json['receiptId'] as int?,
      workStartDate: json['workStartDate'] as String?,
      workEndDate: json['workEndDate'] as String?,
      amount: json['amount'],
      bonus: json['bonus'],
      allowance: json['allowance'],
    );

Map<String, dynamic> _$SalaryToJson(Salary instance) => <String, dynamic>{
      'id': instance.id,
      'receiptId': instance.receiptId,
      'workStartDate': instance.workStartDate,
      'workEndDate': instance.workEndDate,
      'amount': instance.amount,
      'bonus': instance.bonus,
      'allowance': instance.allowance,
    };

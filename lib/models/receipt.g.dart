// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Receipt _$ReceiptFromJson(Map<String, dynamic> json) => Receipt(
      id: json['id'] as int,
      userName: json['user'] as String,
      deductions: (json['deductions'] as List<dynamic>)
          .map((e) => Deduction.fromJson(e))
          .toList(),
      salary: Salary.fromJson(json['salary']),
    );

Map<String, dynamic> _$ReceiptToJson(Receipt instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.userName,
      'deductions': instance.deductions,
      'salary': instance.salary,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Receipt _$ReceiptFromJson(Map<String, dynamic> json) => Receipt(
      id: json['id'] as int,
      user: User.fromJson(json['user']),
      deductions: (json['deductions'] as List<dynamic>)
          .map((e) => Deduction.fromJson(e))
          .toList(),
      salary: Salary.fromJson(json['salary']),
    );

Map<String, dynamic> _$ReceiptToJson(Receipt instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'deductions': instance.deductions,
      'salary': instance.salary,
    };

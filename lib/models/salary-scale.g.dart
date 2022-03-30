// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salary-scale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalaryScale _$SalaryScaleFromJson(Map<String, dynamic> json) => SalaryScale(
      id: json['id'] as int,
      isActive: json['isActive'] as bool,
      salaryScaleJobs: (json['salaryScaleJobs'] as List<dynamic>)
          .map((e) => SalaryScaleJob.fromJson(e))
          .toList(),
    );

Map<String, dynamic> _$SalaryScaleToJson(SalaryScale instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isActive': instance.isActive,
      'salaryScaleJobs': instance.salaryScaleJobs,
    };

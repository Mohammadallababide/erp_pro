// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salary-scale-job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalaryScaleJob _$SalaryScaleJobFromJson(Map<String, dynamic> json) =>
    SalaryScaleJob(
      id: json['id'] as int?,
      jobId: json['jobId'] as int,
      amount: json['amount'] as int,
      employeeLevel: json['employeeLevel'] as String,
      job: json['job'] == null ? null : Job.fromJson(json['job']),
    );

Map<String, dynamic> _$SalaryScaleJobToJson(SalaryScaleJob instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jobId': instance.jobId,
      'amount': instance.amount,
      'employeeLevel': instance.employeeLevel,
      'job': instance.job,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignJob.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobAssign _$JobAssignFromJson(Map<String, dynamic> json) => JobAssign(
      job: json['job'] == null ? null : Job.fromJson(json['job']),
      level: json['level'] as String?,
    );

Map<String, dynamic> _$JobAssignToJson(JobAssign instance) => <String, dynamic>{
      'job': instance.job,
      'level': instance.level,
    };

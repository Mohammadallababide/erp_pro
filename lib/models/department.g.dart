// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
      maxNumberOfEmployees: json['maxNumberOfEmployees'] as int,
      title: json['title'] as String,
      id: json['id'] as int,
      users: (json['users'] as List<dynamic>)
          .map((e) => User.fromJson(e))
          .toList(),
      jobs:
          (json['jobs'] as List<dynamic>).map((e) => Job.fromJson(e)).toList(),
    );

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'maxNumberOfEmployees': instance.maxNumberOfEmployees,
      'title': instance.title,
      'id': instance.id,
      'users': instance.users,
      'jobs': instance.jobs,
    };

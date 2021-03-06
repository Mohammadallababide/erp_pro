// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      salaryScaleJob: json['salaryScaleJob'] == null
          ? null
          : SalaryScaleJob.fromJson(json['salaryScaleJob']),
      salary: json['salary'] as int?,
      jobId: json['jobId'] as int?,
      level: json['level'] as String?,
      id: json['id'] as int?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      password: json['password'] as String?,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      isActive: json['isActive'] as bool? ?? false,
      associatedRoles: (json['associatedRoles'] as List<dynamic>?)
          ?.map((e) => AssociatedRole.fromJson(e))
          .toList(),
      receipts: (json['receipts'] as List<dynamic>?)
          ?.map((e) => Receipt.fromJson(e))
          .toList(),
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      departmentId: json['departmentId'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'password': instance.password,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'isActive': instance.isActive,
      'roles': instance.roles,
      'associatedRoles': instance.associatedRoles,
      'receipts': instance.receipts,
      'jobId': instance.jobId,
      'level': instance.level,
      'departmentId': instance.departmentId,
      'salaryScaleJob': instance.salaryScaleJob,
      'salary': instance.salary,
      'userLeavesCategories': instance.userLeavesCategories,
    };

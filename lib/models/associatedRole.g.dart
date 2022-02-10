// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'associatedRole.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssociatedRole _$AssociatedRoleFromJson(Map<String, dynamic> json) =>
    AssociatedRole(
      id: json['id'] as int,
      roleId: json['roleId'] as int,
      role: Role.fromJson(json['role']),
      userId: json['userId'] as int,
    );

Map<String, dynamic> _$AssociatedRoleToJson(AssociatedRole instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roleId': instance.roleId,
      'role': instance.role,
      'userId': instance.userId,
    };

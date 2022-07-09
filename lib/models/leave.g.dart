// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leave _$LeaveFromJson(Map<String, dynamic> json) => Leave(
      id: json['id'] as int,
      description: json['description'] as String,
      fromDate: json['fromDate'] as String,
      toDate: json['toDate'] as String,
      leaveCategoryId: json['leaveCategoryId'] as int,
      managerId: json['managerId'] as int?,
      manger: json['manger'] == null ? null : User.fromJson(json['manger']),
      requesterId: json['requesterId'] as int?,
      requester:
          json['requester'] == null ? null : User.fromJson(json['requester']),
      status: json['status'] as String?,
      categoryName: json['categoryName'] as String?,
      deductionAmount: json['deductionAmount'] as int?,
    );

Map<String, dynamic> _$LeaveToJson(Leave instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'leaveCategoryId': instance.leaveCategoryId,
      'managerId': instance.managerId,
      'manger': instance.manger,
      'requesterId': instance.requesterId,
      'requester': instance.requester,
      'status': instance.status,
      'categoryName': instance.categoryName,
      'deductionAmount': instance.deductionAmount,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaveCategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveCategory _$LeaveCategoryFromJson(Map<String, dynamic> json) =>
    LeaveCategory(
      id: json['id'] as int,
      name: json['name'] as String?,
      deductionAmount: json['deductionAmount'] as int?,
    );

Map<String, dynamic> _$LeaveCategoryToJson(LeaveCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'deductionAmount': instance.deductionAmount,
    };

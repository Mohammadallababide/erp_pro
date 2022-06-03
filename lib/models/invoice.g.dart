// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
      grossAmount: json['grossAmount'] as int,
      netAmount: json['netAmount'] as int,
      taxNumber: json['taxNumber'] as String,
      dueDate: json['dueDate'] as String,
      issueDate: json['issueDate'] as String,
      submittedById: json['submittedById'] as int,
      status: json['status'] as String,
      rejectedBy:
          json['rejectedBy'] == null ? null : User.fromJson(json['rejectedBy']),
      approvedBy:
          json['approvedBy'] == null ? null : User.fromJson(json['approvedBy']),
      id: json['id'] as int?,
      fileId: json['fileId'] as int?,
      submittedBy: json['submittedBy'] == null
          ? null
          : User.fromJson(json['submittedBy']),
      assigneeId: json['assigneeId'] as int?,
      reviewedById: json['reviewedById'] as int?,
      reviewedBy:
          json['reviewedBy'] == null ? null : User.fromJson(json['reviewedBy']),
      paidById: json['paidById'] as int?,
      paidBy: json['paidBy'] == null ? null : User.fromJson(json['paidBy']),
      assignee:
          json['assignee'] == null ? null : User.fromJson(json['assignee']),
    );

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'id': instance.id,
      'fileId': instance.fileId,
      'status': instance.status,
      'grossAmount': instance.grossAmount,
      'netAmount': instance.netAmount,
      'taxNumber': instance.taxNumber,
      'dueDate': instance.dueDate,
      'issueDate': instance.issueDate,
      'submittedById': instance.submittedById,
      'submittedBy': instance.submittedBy,
      'assigneeId': instance.assigneeId,
      'reviewedById': instance.reviewedById,
      'approvedBy': instance.approvedBy,
      'reviewedBy': instance.reviewedBy,
      'paidById': instance.paidById,
      'paidBy': instance.paidBy,
      'rejectedBy': instance.rejectedBy,
      'assignee': instance.assignee,
    };

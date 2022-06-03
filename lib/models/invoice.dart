import 'package:erb_mobo/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'invoice.g.dart';

@JsonSerializable()
class Invoice {
  @JsonKey(required: false)
  final int? id;
  @JsonKey(required: false)
  final int? fileId;
  @JsonKey(required: false)
  final String status;
  @JsonKey(required: false)
  final int grossAmount;
  @JsonKey(required: false)
  final int netAmount;
  @JsonKey(required: false)
  final String taxNumber;
  @JsonKey(required: false)
  final String dueDate;
  @JsonKey(required: false)
  final String issueDate;
  @JsonKey(required: false)
  final int submittedById;
  @JsonKey(required: false)
  final User? submittedBy;
  @JsonKey(required: false)
  final int? assigneeId;
  @JsonKey(required: false)
  final int? reviewedById;
  @JsonKey(required: false)
  final User? approvedBy;
  @JsonKey(required: false)
  final User? reviewedBy;
  @JsonKey(required: false)
  final int? paidById;
  @JsonKey(required: false)
  final User? paidBy;
  @JsonKey(required: false)
  final User? rejectedBy;
  @JsonKey(required: false)
  final User? assignee;

  Invoice({
    required this.grossAmount,
    required this.netAmount,
    required this.taxNumber,
    required this.dueDate,
    required this.issueDate,
    required this.submittedById,
    required this.status,
    this.rejectedBy,
    this.approvedBy,
    this.id,
    this.fileId,
    this.submittedBy,
    this.assigneeId,
    this.reviewedById,
    this.reviewedBy,
    this.paidById,
    this.paidBy,
    this.assignee,
  });

  factory Invoice.fromJson(json) => _$InvoiceFromJson(json);
  toJson() => _$InvoiceToJson(this);
}

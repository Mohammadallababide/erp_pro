import 'package:erb_mobo/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'leave.g.dart';

@JsonSerializable()
class Leave {
  final int id;
  final String description;
  final String fromDate;
  final String toDate;
  final int leaveCategoryId;
  final int? managerId;
  final User? manger;
  final int? requesterId;
  final User? requester;
  late final String? status;
  final String? categoryName;
  final int? deductionAmount;

  Leave({
    required this.id,
    required this.description,
    required this.fromDate,
    required this.toDate,
    required this.leaveCategoryId,
    this.managerId,
    this.manger,
    this.requesterId,
    this.requester,
    this.status,
    this.categoryName,
    this.deductionAmount,
  });

  factory Leave.fromJson(json) => _$LeaveFromJson(json);
  toJson() => _$LeaveToJson(this);
}

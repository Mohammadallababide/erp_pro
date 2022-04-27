import 'package:json_annotation/json_annotation.dart';
part 'salary.g.dart';

@JsonSerializable()
class Salary {
  @JsonKey(required: false)
  final int? id;
  @JsonKey(required: false)
  final int? receiptId;

  @JsonKey(required: false)
  final String? workStartDate;
  @JsonKey(required: false)
  final String? workEndDate;
  @JsonKey(required: false)
  final dynamic amount;
  @JsonKey(required: false)
  final dynamic bonus;
  @JsonKey(required: false)
  final dynamic allowance;

  Salary({
    this.id,
    this.receiptId,
    this.workStartDate,
    this.workEndDate,
    this.amount,
    required this.bonus,
    required this.allowance,
  });

  factory Salary.fromJson(json) => _$SalaryFromJson(json);
  toJson() => _$SalaryToJson(this);
}

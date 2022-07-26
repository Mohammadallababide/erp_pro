import 'package:json_annotation/json_annotation.dart';
part 'leaveCategory.g.dart';

@JsonSerializable()
class LeaveCategory {
  @JsonKey(required: false)
  final int id;

  @JsonKey(required: false)
  final String? name;
  @JsonKey(required: false)
  final int? deductionAmount;
  @JsonKey(required: false)
  final int? numberOfDaysAllowed;

  LeaveCategory({
    required this.id,
    this.numberOfDaysAllowed,
    this.name,
    this.deductionAmount,
  });
  factory LeaveCategory.fromJson(json) => _$LeaveCategoryFromJson(json);
  toJson() => _$LeaveCategoryToJson(this);
}

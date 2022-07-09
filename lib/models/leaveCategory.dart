import 'package:json_annotation/json_annotation.dart';
part 'leaveCategory.g.dart';

@JsonSerializable()
class LeaveCategory {
  @JsonKey(required: false)
  final int id;

  @JsonKey(required: false)
  final String name;
  @JsonKey(required: false)
  final int deductionAmount;

  LeaveCategory({
    required this.id,
   
    required this.name,
    required this.deductionAmount,
  });
   factory LeaveCategory.fromJson(json) => _$LeaveCategoryFromJson(json);
  toJson() => _$LeaveCategoryToJson(this);
}

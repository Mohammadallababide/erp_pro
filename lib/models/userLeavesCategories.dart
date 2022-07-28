import 'package:erb_mobo/models/leaveCategory.dart';
import 'package:erb_mobo/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserLeaveCategorie {
  @JsonKey(required: false)
  final int? id;
  @JsonKey(required: false)
  final int? leaveCategoryId;
  @JsonKey(required: false)
  final LeaveCategory leaveCategory;
  @JsonKey(required: false)
  final int userId;
  @JsonKey(required: false)
  final User? user;
  @JsonKey(required: false)
  final int numberOfDaysAllowed;

  UserLeaveCategorie({
    this.id,
    this.leaveCategoryId,
    required this.leaveCategory,
    required this.userId,
    this.user,
    required this.numberOfDaysAllowed,
  });
}

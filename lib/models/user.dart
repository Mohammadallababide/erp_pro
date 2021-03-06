import 'package:erb_mobo/models/associatedRole.dart';
import 'package:erb_mobo/models/receipt.dart';
import 'package:erb_mobo/models/salary-scale-job.dart';
import 'package:erb_mobo/models/userLeavesCategories.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(required: false)
  final int? id;
  @JsonKey(required: false)
  final String firstName;
  @JsonKey(required: false)
  final String lastName;
  @JsonKey(required: false)
  final String? password;
  @JsonKey(required: false)
  final String email;
  @JsonKey(required: false)
  final String? phoneNumber;
  @JsonKey(required: false)
  final String? accessToken;
  @JsonKey(required: false)
  final String? refreshToken;
  @JsonKey(required: false)
  late final bool? isActive;
  @JsonKey(required: false)
  final List<String>? roles;
  @JsonKey(required: false)
  final List<AssociatedRole>? associatedRoles;
  @JsonKey(required: false)
  final List<Receipt>? receipts;
  @JsonKey(required: false)
  late final int? jobId;
  @JsonKey(required: false)
  final String? level;
  @JsonKey(required: false)
  final int? departmentId;
  @JsonKey(required: false)
  final SalaryScaleJob? salaryScaleJob;
  @JsonKey(required: false)
  final int? salary;
  final List<UserLeaveCategorie>? userLeavesCategories;

// final Role role;
  User({
    this.userLeavesCategories,
    this.salaryScaleJob,
    this.salary,
    this.jobId,
    this.level,
    this.id,
    required this.firstName,
    required this.lastName,
    this.password,
    required this.email,
    this.phoneNumber,
    this.accessToken,
    this.refreshToken,
    this.isActive = false,
    this.associatedRoles,
    this.receipts,
    this.roles,
    this.departmentId,
  });

  factory User.fromJson(json) => _$UserFromJson(json);
  toJson() => _$UserToJson(this);
}

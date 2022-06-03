import 'package:erb_mobo/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

import 'job.dart';
part 'department.g.dart';

@JsonSerializable()
class Department {
  @JsonKey(required: false)
  final int maxNumberOfEmployees;
  @JsonKey(required: false)
  final String title;
  @JsonKey(required: false)
  final int id;
  @JsonKey(required: false)
  final List<User> users;
  @JsonKey(required: false)
  final List<Job> jobs;

  Department({
    required this.maxNumberOfEmployees,
    required this.title,
    required this.id,
    required this.users,
    required this.jobs,
  });
  factory Department.fromJson(json) => _$DepartmentFromJson(json);
  toJson() => _$DepartmentToJson(this);
}

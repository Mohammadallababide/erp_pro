import 'package:json_annotation/json_annotation.dart';
part 'role.g.dart';

@JsonSerializable()
class Role {
  @JsonKey(required: false)
  final int id;
  @JsonKey(required: false)
  final String name;

  Role({
    required this.id,
    required this.name,
  });
  factory Role.fromJson(json) => _$RoleFromJson(json);
  toJson() => _$RoleToJson(this);
}

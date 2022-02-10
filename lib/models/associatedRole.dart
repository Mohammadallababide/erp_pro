import 'package:erb_mobo/models/role.dart';
import 'package:json_annotation/json_annotation.dart';
part 'associatedRole.g.dart';

@JsonSerializable()
class AssociatedRole {
  @JsonKey(required: false)
  final int id;
  @JsonKey(required: false)
  final int roleId;
  @JsonKey(required: false)
  final Role role;
  @JsonKey(required: false)
  final int userId;

  AssociatedRole({
    required this.id,
    required this.roleId,
    required this.role,
    required this.userId,
  });
    factory AssociatedRole.fromJson(json) => _$AssociatedRoleFromJson(json);
  toJson() => _$AssociatedRoleToJson(this);
}

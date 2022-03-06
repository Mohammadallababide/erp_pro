import 'package:erb_mobo/models/associatedRole.dart';
import 'package:erb_mobo/models/receipt.dart';
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

// final Role role;
  User({
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
  });

  factory User.fromJson(json) => _$UserFromJson(json);
  toJson() => _$UserToJson(this);
}

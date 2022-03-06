import 'package:erb_mobo/models/deduction.dart';
import 'package:erb_mobo/models/salary.dart';
import 'package:erb_mobo/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'receipt.g.dart';


@JsonSerializable()
class Receipt {
  @JsonKey(required: false)
  final int id;
  @JsonKey(required: false, name: 'user')
  final User user;
  @JsonKey(required: false)
  final List<Deduction> deductions;
  @JsonKey(required: false)
  final Salary salary;
  Receipt({
    required this.id,
    required this.user,
    required this.deductions,
    required this.salary,
  });

    factory Receipt.fromJson(json) => _$ReceiptFromJson(json);
  toJson() => _$ReceiptToJson(this);
}

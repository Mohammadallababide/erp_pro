import 'package:json_annotation/json_annotation.dart';
part 'deduction.g.dart';


@JsonSerializable()
class Deduction {
  @JsonKey(required: false)
  final dynamic amount;
  @JsonKey(required: false)
  final String type;
  @JsonKey(required: false)
  final String reason;

  Deduction({
    required this.amount,
    required this.type,
    required this.reason,
  });

  factory Deduction.fromJson(json) => _$DeductionFromJson(json);
  toJson() => _$DeductionToJson(this);
}

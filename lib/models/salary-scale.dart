import 'package:erb_mobo/models/salary-scale-job.dart';
import 'package:json_annotation/json_annotation.dart';
part 'salary-scale.g.dart';

@JsonSerializable()
class SalaryScale {
  @JsonKey(required: false)
  final int id;
  @JsonKey(required: false)
  final bool isActive;
  @JsonKey(required: false)
  final List<SalaryScaleJob> salaryScaleJobs;

  SalaryScale({
    required this.id,
    required this.isActive,
    required this.salaryScaleJobs,
  });
  factory SalaryScale.fromJson(json) => _$SalaryScaleFromJson(json);
  toJson() => _$SalaryScaleToJson(this);
}

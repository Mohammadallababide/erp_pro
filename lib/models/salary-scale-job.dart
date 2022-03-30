import 'package:erb_mobo/models/job.dart';
import 'package:json_annotation/json_annotation.dart';
part 'salary-scale-job.g.dart';

@JsonSerializable()
class SalaryScaleJob {
  @JsonKey(required: false)
  final int? id;
  @JsonKey(required: false)
  final int jobId;
  @JsonKey(required: false)
  final int amount;
  @JsonKey(required: false)
  final String employeeLevel;
  @JsonKey(required: false)
  final Job? job;

  SalaryScaleJob( {
     this.id,
    required this.jobId,
    required this.amount,
    required this.employeeLevel,
    this.job,
  });

  factory SalaryScaleJob.fromJson(json) => _$SalaryScaleJobFromJson(json);
  toJson() => _$SalaryScaleJobToJson(this);
}

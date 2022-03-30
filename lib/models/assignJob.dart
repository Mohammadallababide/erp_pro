import 'package:json_annotation/json_annotation.dart';

import 'job.dart';
part 'assignJob.g.dart';

@JsonSerializable()
class JobAssign {
  @JsonKey(required: false)
   Job? job;
  @JsonKey(required: false)
   String? level;

  JobAssign({
      this.job,
      this.level,
  });
  //     factory JobAssign.fromJson(json) => _$AssignJobFromJson(json);
  // toJson() => _$AssignJobToJson(this);
}

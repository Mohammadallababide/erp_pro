import 'package:json_annotation/json_annotation.dart';

part 'job.g.dart';

@JsonSerializable()
class Job {
  @JsonKey(required: false)
  final int id;
  @JsonKey(required: false)
  final String name;
  @JsonKey(required: false)
  final String description;

  Job({
    required this.id,
    required this.name,
    required this.description,
  });
  factory Job.fromJson(json) => _$JobFromJson(json);
  toJson() => _$JobToJson(this);
}

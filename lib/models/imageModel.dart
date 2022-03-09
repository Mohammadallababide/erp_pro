import 'package:json_annotation/json_annotation.dart';
part 'imageModel.g.dart';

@JsonSerializable()
class ImageModel {
  @JsonKey(required: true)
  final String url;
  @JsonKey(required: true)
  final int id;

  ImageModel(this.url, this.id);
    factory ImageModel.fromJson(json) => _$ImageModelFromJson(json);
  toJson() => _$ImageModelToJson(this);
}

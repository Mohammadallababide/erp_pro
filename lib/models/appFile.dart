import 'package:json_annotation/json_annotation.dart';
part 'appFile.g.dart';

@JsonSerializable()
class AppFile {
  @JsonKey(required: false, name: 'filename')
  final String fileName;

  @JsonKey(required: false)
  final String path;

  @JsonKey(required: false, name: 'mimetype')
  final String mimeType;

  @JsonKey(required: false)
  final String url;

  AppFile({
    required this.fileName,
    required this.path,
    required this.mimeType,
    required this.url,
  });

  factory AppFile.fromJson(json) => _$AppFileFromJson(json);
  toJson() => _$AppFileToJson(this);
}

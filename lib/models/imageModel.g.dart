// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imageModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['url', 'id'],
  );
  return ImageModel(
    json['url'] as String,
    json['id'] as int,
  );
}

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'id': instance.id,
    };

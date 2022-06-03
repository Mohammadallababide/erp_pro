// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppFile _$AppFileFromJson(Map<String, dynamic> json) => AppFile(
      fileName: json['filename'] as String,
      path: json['path'] as String,
      mimeType: json['mimetype'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$AppFileToJson(AppFile instance) => <String, dynamic>{
      'filename': instance.fileName,
      'path': instance.path,
      'mimetype': instance.mimeType,
      'url': instance.url,
    };

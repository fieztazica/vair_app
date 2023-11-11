import 'dart:convert';

import 'package:vair_app/models/MediaModel.dart';

class ImageModel extends MediaModel {
  final String name;
  final String? alternativeText;
  final String? caption;
  final int width;
  final int height;
  final Map<String, ImageFormatModel> formats;
  final String hash;
  final String ext;
  final String mime;
  final double size;
  final String url;
  final String previewUrl;
  final String provider;
  final String? provider_metadata;

  ImageModel(
      {required super.id,
      required this.name,
      required this.alternativeText,
      required this.caption,
      required this.width,
      required this.height,
      required this.formats,
      required this.hash,
      required this.ext,
      required this.mime,
      required this.size,
      required this.url,
      required this.previewUrl,
      required this.provider,
      required this.provider_metadata,
      required super.createdAt,
      required super.updatedAt});

  factory ImageModel.fromRawJson(String str) =>
      ImageModel.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json["id"] as String,
        name: json["name"] as String,
        alternativeText: json["alternativeText"] as String,
        caption: json["caption"] as String,
        width: json["width"] as int,
        height: json["height"] as int,
        formats: json['formats'] as Map<String, ImageFormatModel>,
        hash: json["hash"] as String,
        ext: json["ext"] as String,
        mime: json["mime"] as String,
        size: json["size"] as double,
        url: json["url"] as String,
        previewUrl: json["previewUrl"] as String,
        provider: json["provider"] as String,
        provider_metadata: json["provider_metadata"] as String?,
        createdAt: DateTime.parse(json["createdAt"] as String),
        updatedAt: DateTime.parse(json["updatedAt"] as String),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class ImageFormatModel {
  final String name;
  final String hash;
  final String ext;
  final String mime;
  final String? path;
  final int width;
  final int height;
  final double size;
  final String url;

  ImageFormatModel(
      {required this.name,
      required this.hash,
      required this.ext,
      required this.mime,
      required this.path,
      required this.width,
      required this.height,
      required this.size,
      required this.url});

  factory ImageFormatModel.fromRawJson(String str) =>
      ImageFormatModel.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory ImageFormatModel.fromJson(Map<String, dynamic> json) =>
      ImageFormatModel(
        name: json["name"] as String,
        width: json["width"] as int,
        height: json["height"] as int,
        ext: json["ext"] as String,
        path: json["path"] as String?,
        mime: json["mime"] as String,
        hash: json["hash"] as String,
        size: json["size"] as double,
        url: json["url"] as String,
      );

  Map<String, dynamic> toJson() => {};
}

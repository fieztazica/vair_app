import 'package:vair_app/models/Thumbnail.dart';

class Formats {
  Thumbnail? thumbnail;
  Thumbnail? large;
  Thumbnail? medium;
  Thumbnail? small;

  Formats({this.thumbnail, this.large, this.medium, this.small});

  Formats.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'] != null
        ? Thumbnail.fromJson(json['thumbnail'])
        : null;
    large =
        json['large'] != null ? Thumbnail.fromJson(json['large']) : null;
    medium =
        json['medium'] != null ? Thumbnail.fromJson(json['medium']) : null;
    small =
        json['small'] != null ? Thumbnail.fromJson(json['small']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail!.toJson();
    }
    if (large != null) {
      data['large'] = large!.toJson();
    }
    if (medium != null) {
      data['medium'] = medium!.toJson();
    }
    if (small != null) {
      data['small'] = small!.toJson();
    }
    return data;
  }
}

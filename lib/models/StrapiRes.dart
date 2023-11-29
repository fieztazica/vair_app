import 'package:vair_app/models/StrapiError.dart';
import 'package:vair_app/models/Meta.dart';

class StrapiRes<T> {
  T? data;
  Meta? meta;
  StrapiError? error;

  StrapiRes({this.data, this.meta, this.error});

  StrapiRes.fromJson(Map<String, dynamic> json, Function dataDecoder) {
    data = json['data'] != null ? dataDecoder(json['data']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    error = json['error'] != null ? StrapiError.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    if (this.error != null) {
      data['error'] = this.error!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

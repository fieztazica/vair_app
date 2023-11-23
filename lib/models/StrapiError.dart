class StrapiError {
  int? status;
  String? name;
  String? message;
  Details? details;

  StrapiError({this.status, this.name, this.message, this.details});

  StrapiError.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    name = json['name'];
    message = json['message'];
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['name'] = name;
    data['message'] = message;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    return data;
  }
}

class Details {
  List<DetailError>? errors;

  Details({this.errors});

  Details.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      errors = <DetailError>[];
      json['errors'].forEach((v) {
        errors!.add(DetailError.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DetailError {
  List<String>? path;
  String? message;
  String? name;

  DetailError({this.path, this.message, this.name});

  DetailError.fromJson(Map<String, dynamic> json) {
    path = json['path'].cast<String>();
    message = json['message'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = path;
    data['message'] = message;
    data['name'] = name;
    return data;
  }
}

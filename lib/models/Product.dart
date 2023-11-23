import 'package:vair_app/models/Banner.dart';

class Product {
  int? id;
  String? name;
  String? description;
  double? price;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  List<Banner>? banners;
  Banner? logo;

  Product(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.banners,
      this.logo});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    if (json['banners'] != null) {
      banners = <Banner>[];
      json['banners'].forEach((v) {
        banners!.add(Banner.fromJson(v));
      });
    }
    logo = json['logo'] != null ? Banner.fromJson(json['logo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['publishedAt'] = publishedAt;
    if (banners != null) {
      data['banners'] = banners!.map((v) => v.toJson()).toList();
    }
    if (logo != null) {
      data['logo'] = logo!.toJson();
    }
    return data;
  }
}

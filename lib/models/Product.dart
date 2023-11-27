import 'package:vair_app/models/Asset.dart';
import 'package:vair_app/models/Category.dart';
import 'package:vair_app/models/Developer.dart';
import 'package:vair_app/models/Publisher.dart';

class Product {
  int? id;
  String? name;
  String? description;
  double? price;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  List<Asset>? banners;
  Asset? logo;
  List<Category>? categories;
  Developer? developer;
  Publisher? publisher;

  Product(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.banners,
      this.logo,
      this.categories,
      this.developer,
      this.publisher});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    if (json['banners'] != null) {
      banners = <Asset>[];
      json['banners'].forEach((v) {
        banners!.add(Asset.fromJson(v));
      });
    }
    logo = json['logo'] != null ? Asset.fromJson(json['logo']) : null;
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
    developer = json['developer'] != null
        ? Developer.fromJson(json['developer'])
        : null;
    publisher = json['publisher'] != null
        ? Publisher.fromJson(json['publisher'])
        : null;
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
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (developer != null) {
      data['developer'] = developer!.toJson();
    }
    if (publisher != null) {
      data['publisher'] = publisher!.toJson();
    }
    return data;
  }
}

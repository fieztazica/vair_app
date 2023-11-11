import 'dart:convert';
import 'package:vair_app/models/BaseModel.dart';
import 'package:vair_app/models/ImageModel.dart';

class ProductModel extends BaseModel {
  final String name;
  final String description;
  final double price;
  final ImageModel logo;
  final List<ImageModel> banners;

  ProductModel(
      {required super.id,
      required this.name,
      required this.description,
      this.price = 0,
      required this.logo,
      required this.banners,
      required super.createdAt,
      required super.updatedAt});

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"] as String,
        name: json["name"] as String,
        description: json["description"] as String,
        createdAt: DateTime.parse(json["createdAt"] as String),
        updatedAt: DateTime.parse(json["updatedAt"] as String),
        logo: ImageModel.fromJson(json['logo']),
        banners: [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

import 'package:vair_app/models/AuthUser.dart';
import 'package:vair_app/models/Product.dart';
import 'package:vair_app/models/StrapiRes.dart';

class AppConverter {
  static AuthUser? convertAuthUser(dynamic input) {
    try {
      Map<String, dynamic> json = Map.from(input);
      AuthUser data = AuthUser.fromJson(json);
      return data;
    } catch (e) {
      return null;
    }
  }

  static StrapiRes<T> httpDecoder<T>(dynamic input, Function dataDecoder) {
    Map<String, dynamic> json = Map.from(input);
    StrapiRes<T> data = StrapiRes<T>.fromJson(json, dataDecoder);
    return data;
  }

  static StrapiRes<Product> httpProductDecoder<T>(dynamic input) {
    Map<String, dynamic> json = Map.from(input);
    StrapiRes<Product> data =
        StrapiRes<Product>.fromJson(json, Product.fromJson);
    return data;
  }
}

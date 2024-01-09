import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndPoints {
  static String strapiBaseUrl = dotenv.get("strapiBaseUrl");
  static String expressBaseUrl = dotenv.get("expressBaseUrl");
  static String strapiBaseApiURL = '$strapiBaseUrl/api';
  static String expressBaseApiURL = "$expressBaseUrl/api";
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
  static _ProductEndPoints productEndPoints = _ProductEndPoints();
}

class _AuthEndPoints {
  static const String basePath = "auth";

  final String registerEmail = "$basePath/local/register";
  final String loginEmail = 'auth/local';
}

class _ProductEndPoints {
  static const String basePath = "products";

  String expressBasePath() => "${ApiEndPoints.expressBaseApiURL}/$basePath";

  final String featuredProducts = "$basePath/featured";

  String base() => basePath;

  String buy(int productId, {bool withBasePath = true}) =>
      "${withBasePath ? expressBasePath() : ''}/$productId/buy";

  String feedback(int productId, {bool withBasePath = true}) =>
      "${withBasePath ? expressBasePath() : ''}/$productId/feedback";

  String download(int productId, {bool withBasePath = true}) =>
      "${withBasePath ? expressBasePath() : ''}/$productId/download";

  String search(String query) => "${expressBasePath()}/search?q=$query";
}

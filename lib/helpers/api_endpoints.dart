class ApiEndPoints {
  static const String strapiBaseUrl = "https://strapi.vair.nyte.tk";
  static const String expressBaseUrl = "http://192.168.100.5:5000";
  static const String strapiBaseApiURL = '$strapiBaseUrl/api';
  static const String expressBaseApiURL = "$expressBaseUrl/api";
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

  final String featuredProducts = "$basePath/featured";
}

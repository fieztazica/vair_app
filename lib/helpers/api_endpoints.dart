class ApiEndPoints {
  static const String strapiBaseApiURL = 'https://strapi.vair.nyte.tk/api';
  static const String expressBaseApiURL = "https://express.vair.nyte.tk/api";
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

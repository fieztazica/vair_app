class ApiEndPoints {
  static const String strapiBaseApiURL = 'https://strapi.vair.nyte.tk/api';
  static const String expressBaseApiURL = "https://express.vair.nyte.tk/api";
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'auth/local/register';
  final String loginEmail = 'auth/local';
}

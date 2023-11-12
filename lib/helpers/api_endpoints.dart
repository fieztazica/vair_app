class ApiEndPoints {
  static final String baseUrl = 'http://strapi.vair.nyte.tk/api/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'auth/local/register';
  final String loginEmail = 'auth/local';
}

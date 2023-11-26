import 'package:get/get.dart';
import 'package:vair_app/helpers/api_endpoints.dart';
import 'package:vair_app/shared/GetBaseProvider.dart';

class AuthProvider extends GetBaseProvider {
  @override
  void onInit() {
    super.onInit();
  }

  Future<Response> localLogin(String identifier, String password) async {
    Map body = {'identifier': identifier, 'password': password};
    return post(
        "${ApiEndPoints.strapiBaseApiURL}/${ApiEndPoints.authEndpoints.loginEmail}",
        body);
  }

  Future<Response> localRegister(
      String username, String email, String password) async {
    Map body = {'username': username, 'email': email, 'password': password};
    return post(
        "${ApiEndPoints.strapiBaseApiURL}/${ApiEndPoints.authEndpoints.registerEmail}",
        body);
  }
}

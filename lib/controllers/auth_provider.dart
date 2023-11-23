import 'package:get/get.dart';
import 'package:vair_app/helpers/api_endpoints.dart';
import 'package:vair_app/models/AuthUser.dart';
import 'package:vair_app/shared/GetBaseProvider.dart';

class AuthProvider extends GetBaseProvider {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = AuthUser.fromJson as dynamic;
    httpClient.baseUrl = '${ApiEndPoints.strapiBaseApiURL}/auth';

    super.addResponseModifier<AuthUser>(strapiRes: false);
  }

  Future<Response> localLogin(String identifier, String password) async {
    Map body = {'identifier': identifier, 'password': password};
    return post(
        "${ApiEndPoints.strapiBaseApiURL}${ApiEndPoints.authEndpoints.loginEmail}",
        body);
  }
}

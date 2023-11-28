import 'package:get/get.dart';
import 'package:vair_app/helpers/box.dart';

class GetBaseProvider extends GetConnect {
  final box = Box();

  void addAuthenticator() {
    var authUser = box.authUser;
    if (authUser != null && authUser.jwt != null) {
      httpClient.addAuthenticator<dynamic>((request) async {
        final token = box.authUser!.jwt!;
        // Set the header
        request.headers['Authorization'] = "Bearer $token";
        return request;
      });
    }

    //Autenticator will be called 3 times if HttpStatus is
    //HttpStatus.unauthorized
    httpClient.maxAuthRetries = 3;
  }

  void setDefaultDecoder(dynamic decoder) {
    httpClient.defaultDecoder = decoder as dynamic;
  }

  void addRequestModifier() {
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Content-Type'] = 'application/json';
      return request;
    });
  }

  @override
  void onInit() {
    super.onInit();
    addRequestModifier();
  }
}

import 'package:get/get.dart';
import 'package:vair_app/helpers/box.dart';

class GetBaseProvider extends GetConnect {
  final box = Box();

  void addAuthenticator() {
    httpClient.addAuthenticator<dynamic>((request) async {
      final token = box.authUser!.jwt;
      print(token);
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = "Bearer $token";
      }
      return request;
    });

    //Autenticator will be called 3 times if HttpStatus is
    //HttpStatus.unauthorized
    httpClient.maxAuthRetries = 3;
  }

  void setDefaultDecoder(dynamic decoder) {
    httpClient.defaultDecoder = decoder as dynamic;
  }

  void addRequestModifier() {
    httpClient.addRequestModifier<dynamic>((request) {
      print("addRequestModifier");
      request.headers['Content-Type'] = 'application/json; charset=UTF-8';
      return request;
    });
  }

  @override
  void onInit() {
    super.onInit();
    addRequestModifier();
  }
}

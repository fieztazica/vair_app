import 'package:get/get.dart';
import 'package:vair_app/helpers/api_endpoints.dart';
import 'package:vair_app/helpers/app_converter.dart';
import 'package:vair_app/models/StrapiRes.dart';
import 'package:vair_app/shared/GetBaseProvider.dart';

class ProductProvider extends GetBaseProvider {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = '${ApiEndPoints.expressBaseApiURL}/products';
    // super.addAuthenticator();
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

  Future<Response<StrapiRes<T>>> getProducts<T>(
          String path, Function decoder) =>
      get(path, decoder: (input) => StrapiRes.fromJson(input, decoder));
}

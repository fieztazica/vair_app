import 'package:get/get.dart';
import 'package:vair_app/helpers/api_endpoints.dart';
import 'package:vair_app/models/StrapiRes.dart';
import 'package:vair_app/shared/GetBaseProvider.dart';

class ProductProvider extends GetBaseProvider {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = '${ApiEndPoints.expressBaseApiURL}/products';
    super.addAuthenticator();
  }

  Future<Response<StrapiRes<T>>> getProducts<T>(String path) => get(path);
}

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vair_app/models/StrapiRes.dart';
import 'package:vair_app/shared/const_keys.dart';

class GetBaseProvider extends GetConnect {
  final box = GetStorage();

  void addAuthenticator() {
    httpClient.addAuthenticator<dynamic>((request) async {
      final token = box.read(ConstKeys.strapiToken.name);
      // Set the header
      request.headers['Authorization'] = "Bearer $token";
      return request;
    });

    //Autenticator will be called 3 times if HttpStatus is
    //HttpStatus.unauthorized
    httpClient.maxAuthRetries = 3;
  }

  void addResponseModifier<T>({bool? strapiRes = true}) {
    if (strapiRes == true) {
      httpClient.addResponseModifier<StrapiRes<T>>((request, response) {
        StrapiRes<T>? model = response.body;
        T? data = model?.data;
        return data;
      });
    } else {
      httpClient.addResponseModifier<T>((request, response) {
        T? model = response.body;
        return model;
      });
    }
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

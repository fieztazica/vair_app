import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:vair_app/models/Product.dart';

class HomeTabController extends GetxController with StateMixin<List<Product>> {
  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.empty());
    getData();
  }

  void getData() async {
    try {
      change(null, status: RxStatus.loading());

      var res =
          await get(Uri.parse('https://express.vair.nyte.tk/api/products'));

      print("API Response: ${res.statusCode} - ${res.body}");

      if (res.statusCode == 200 && res.body != null) {
        var responseBody = json.decode(res.body);

        if (responseBody['data'] is List) {
          List<Product> products = List<Product>.from(
            (responseBody['data'] as List)
                .map((dynamic item) => Product.fromJson(item)),
          );
          change(products, status: RxStatus.success());
        } else {
          // Handle the case when the "data" field is not a list
          throw "Invalid response format: ${res.body}";
        }
      } else {
        print("API Response: ${res?.statusCode} - ${res?.body}");
      }
    } catch (e) {
      print("Error in getData: $e");
      change(null, status: RxStatus.error("$e"));
    }
  }

  void onClose() {
    super.onClose();
    change(null, status: RxStatus.empty());
  }
}

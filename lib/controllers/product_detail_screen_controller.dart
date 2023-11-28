import 'package:get/get.dart';
import 'package:vair_app/models/Product.dart';
import 'package:vair_app/providers/product_provider.dart';

class ProductDetailScreenController extends GetxController
    with StateMixin<Product> {
  final ProductProvider productProvider = Get.put(ProductProvider());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    change(null, status: RxStatus.empty());
    getData();
  }

  void getData() async {
    try {
      change(null, status: RxStatus.loading());
      String? productId = Get.parameters["id"];
      var res = await productProvider.getProducts<Product>("/$productId");

      if (res.statusCode == 200) {
        if (res.body?.data == null) {
          throw "Empty Response";
        }

        change(res.body!.data!, status: RxStatus.success());
      } else {
        throw (res.body)!.error!.message ?? "Unknown Error Occurred";
      }
    } catch (e) {
      change(null, status: RxStatus.error("$e"));
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    change(null, status: RxStatus.empty());
  }
}

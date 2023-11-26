import 'package:get/get.dart';
import 'package:vair_app/controllers/product_detail_screen_controller.dart';
import 'package:vair_app/providers/product_provider.dart';

class ProductBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ProductDetailScreenController());
    Get.lazyPut(() => ProductProvider());
  }
}

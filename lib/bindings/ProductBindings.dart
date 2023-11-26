import 'package:get/get.dart';
import 'package:vair_app/providers/product_provider.dart';

class ProductBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductProvider());
  }
}

import 'package:get/get.dart';
import 'package:vair_app/providers/product_provider.dart';

class ProductDetailScreenController extends GetxController {
  final ProductProvider productProvider = Get.put(ProductProvider());
}

import 'package:get/get.dart';
import 'package:vair_app/providers/product_provider.dart';

class HomeTabController extends GetxController {
   final ProductProvider productProvider = Get.put(ProductProvider());
}

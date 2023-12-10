import 'package:get/get.dart';
import 'package:vair_app/controllers/auth_controller.dart';
import 'package:vair_app/controllers/home_tab_controller.dart';
import 'package:vair_app/controllers/library_tab_controller.dart';
import 'package:vair_app/controllers/main_screen_controller.dart';
import 'package:vair_app/providers/product_provider.dart';

class MainScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    // Get.put(HomeTabController());
    // Get.put(LibraryTabController());
    Get.lazyPut(() => MainScreenController());
    Get.lazyPut(() => ProductProvider());
  }
}

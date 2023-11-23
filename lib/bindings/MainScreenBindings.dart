import 'package:get/get.dart';
import 'package:vair_app/screens/main_screen.dart';

class MainScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainScreenController());
  }
}

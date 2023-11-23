import 'package:get/get.dart';
import 'package:vair_app/screens/auth/signin_screen.dart';
import 'package:vair_app/screens/main_screen.dart';

class RootBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SigninScreenController());
    Get.lazyPut(() => SigninScreenController());
  }
}

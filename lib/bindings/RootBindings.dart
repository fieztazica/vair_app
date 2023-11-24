import 'package:get/get.dart';
import 'package:vair_app/controllers/auth_controller.dart';
import 'package:vair_app/controllers/signin_screen_controller.dart';
import 'package:vair_app/controllers/signup_screen_controller.dart';

class RootBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(() => AuthController());
    Get.lazyPut(() => SigninScreenController());
    Get.lazyPut(() => SignupScreenController());
  }
}

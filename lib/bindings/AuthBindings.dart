import 'package:get/get.dart';
import 'package:vair_app/controllers/signin_screen_controller.dart';
import 'package:vair_app/controllers/signup_screen_controller.dart';
import 'package:vair_app/providers/auth_provider.dart';

class AuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SigninScreenController());
    Get.lazyPut(() => SignupScreenController());
    Get.lazyPut(() => AuthProvider());
  }
}

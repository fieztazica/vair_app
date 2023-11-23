import 'package:get/get.dart';
import 'package:vair_app/controllers/auth_provider.dart';
import 'package:vair_app/screens/auth/signin_screen.dart';
import 'package:vair_app/screens/main_screen.dart';

class AuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SigninScreenController());
    Get.lazyPut(() => SigninScreenController());
    Get.lazyPut(() => AuthProvider());
  }
}

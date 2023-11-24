import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/controllers/auth_controller.dart';
import 'package:vair_app/providers/auth_provider.dart';
import 'package:vair_app/routes/app_pages.dart';
import 'package:vair_app/shared/const_keys.dart';

class SigninScreenController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();

  final FocusNode focusNodePassword = FocusNode();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final AuthController authController = AuthController();
  final AuthProvider authProvider = AuthProvider();

  var obscurePassword = true.obs;

  void triggerObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> loginWithEmail() async {
    try {
      var response = await authProvider.localLogin(
          controllerUsername.text.trim(), controllerPassword.text);

      if (response.statusCode == 200) {
        // var token = response.body['token'];
        // var user = response.body['user'];
        await authProvider.box.write(ConstKeys.authUser.name, response.body);

        controllerUsername.clear();
        controllerPassword.clear();
        Get.offAllNamed(Routes.MAIN);
      } else {
        throw (response.body)["error"]["message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      authController.reset();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }

  @override
  void onClose() {
    controllerUsername.dispose();
    controllerPassword.dispose();
    focusNodePassword.dispose();
    super.onClose();
  }
}

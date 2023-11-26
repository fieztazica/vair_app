import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/helpers/box.dart';
import 'package:vair_app/providers/auth_provider.dart';
import 'package:vair_app/routes/app_pages.dart';
import 'package:vair_app/shared/const_keys.dart';

class SigninScreenController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();

  final FocusNode focusNodePassword = FocusNode();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final AuthProvider authProvider = Get.put(AuthProvider());
  final Box box = Box();

  var obscurePassword = true.obs;

  void triggerObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> loginWithEmail() async {
    try {
      Get.snackbar("Vair", "Signing you in...", showProgressIndicator: true);
      // Snackbar.normal("Signing you in...");
      var response = await authProvider.localLogin(
          controllerUsername.text.trim(), controllerPassword.text);

      if (response.statusCode == 200) {
        // var token = response.body['token'];
        // var user = response.body['user'];
        await box.def.write(ConstKeys.authUser.name, response.body);

        controllerUsername.clear();
        controllerPassword.clear();
        Get.offAllNamed(Routes.MAIN);
      } else {
        throw (response.body)["error"]["message"] ?? "Unknown Error Occurred";
      }
    } catch (error) {
      Get.dialog(SimpleDialog(
        title: const Text('Error'),
        contentPadding: const EdgeInsets.all(20),
        children: [Text(error.toString())],
      ));
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

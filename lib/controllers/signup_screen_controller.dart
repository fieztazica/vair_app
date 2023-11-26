import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/providers/auth_provider.dart';
import 'package:vair_app/routes/app_pages.dart';
import 'package:vair_app/shared/const_keys.dart';

class SignupScreenController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodeConfirmPassword = FocusNode();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerConFirmPassword =
      TextEditingController();

  final AuthProvider authProvider = Get.put(AuthProvider());

  var obscurePassword = true.obs;

  void triggerObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  @override
  void onClose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    focusNodeConfirmPassword.dispose();
    controllerUsername.dispose();
    controllerEmail.dispose();
    controllerPassword.dispose();
    controllerConFirmPassword.dispose();
    super.onClose();
  }

  Future<void> registerWithEmail() async {
    try {
      Get.snackbar("Vair", "Signing you up...", showProgressIndicator: true);
      // Snackbar.normal("Signing you in...");
      var response = await authProvider.localRegister(
          controllerUsername.text.trim(),
          controllerEmail.text.trim(),
          controllerPassword.text);

      if (response.statusCode == 200) {
        // var token = response.body['token'];
        // var user = response.body['user'];
        await authProvider.box.write(ConstKeys.authUser.name, response.body);

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
}

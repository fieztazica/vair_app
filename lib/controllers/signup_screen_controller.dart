import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
}

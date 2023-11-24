import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/controllers/auth_controller.dart';
import 'package:vair_app/controllers/auth_provider.dart';
import 'package:vair_app/models/AuthUser.dart';
import 'package:vair_app/models/User.dart';
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

class SigninScreen extends StatelessWidget {
  final controller = Get.put(SigninScreenController());
  final authController = Get.put(AuthController());

  SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 150),
              Text(
                "Welcome back",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Login to your account",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 60),
              TextFormField(
                controller: controller.controllerUsername,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onEditingComplete: () =>
                    controller.focusNodePassword.requestFocus(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter username.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Obx(() => TextFormField(
                    controller: controller.controllerPassword,
                    focusNode: controller.focusNodePassword,
                    obscureText: controller.obscurePassword.value,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.password_outlined),
                      suffixIcon: IconButton(
                          onPressed: () => controller.triggerObscurePassword(),
                          icon: controller.obscurePassword.value
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(Icons.visibility_off_outlined)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password.";
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 60),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (controller.formKey.currentState?.validate() ??
                          false) {
                        controller.loginWithEmail();
                      }
                    },
                    child: const Text("Login"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          controller.formKey.currentState?.reset();
                          Get.offAndToNamed(Routes.SIGNUP);
                        },
                        child: const Text("Signup"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

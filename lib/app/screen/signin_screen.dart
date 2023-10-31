import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/app/screen/navbar_screen.dart';
import 'package:vair_app/app/screen/signup_screen.dart';
import 'package:vair_app/controller/auth_controller.dart';

class SigninScreenController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();

  final FocusNode focusNodePassword = FocusNode();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  var obscurePassword = true.obs;

  void triggerObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
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
                        authController.signInUser(
                            controller.controllerUsername.text,
                            controller.controllerPassword.text);
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
                          Get.offAndToNamed('/signup');
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

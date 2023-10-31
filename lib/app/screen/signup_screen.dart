import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/app/screen/signin_screen.dart';
import 'package:vair_app/controller/auth_controller.dart';

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

class SignupScreen extends StatelessWidget {
  final controller = Get.put(SignupScreenController());
  final authController = Get.put(AuthController());

  SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text(
                "Register",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Create your account",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 35),
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
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter username.";
                  }

                  return null;
                },
                onEditingComplete: () =>
                    controller.focusNodeEmail.requestFocus(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.controllerEmail,
                focusNode: controller.focusNodeEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email.";
                  } else if (!(value.contains('@') && value.contains('.'))) {
                    return "Invalid email";
                  }
                  return null;
                },
                onEditingComplete: () =>
                    controller.focusNodePassword.requestFocus(),
              ),
              const SizedBox(height: 10),
              Obx(() => TextFormField(
                    controller: controller.controllerPassword,
                    obscureText: controller.obscurePassword.value,
                    focusNode: controller.focusNodePassword,
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
                      } else if (value.length < 8) {
                        return "Password must be at least 8 character.";
                      }
                      return null;
                    },
                    onEditingComplete: () =>
                        controller.focusNodeConfirmPassword.requestFocus(),
                  )),
              const SizedBox(height: 10),
              Obx(() => TextFormField(
                    controller: controller.controllerConFirmPassword,
                    obscureText: controller.obscurePassword.value,
                    focusNode: controller.focusNodeConfirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
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
                      } else if (value != controller.controllerPassword.text) {
                        return "Password doesn't match.";
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 50),
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
                        authController.signUpUser(
                            username: controller.controllerUsername.text,
                            password: controller.controllerConFirmPassword.text,
                            email: controller.controllerEmail.text);

                        controller.formKey.currentState?.reset();
                      }
                    },
                    child: const Text("Register"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () => Get.offAndToNamed('/signin'),
                        child: const Text("Login"),
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

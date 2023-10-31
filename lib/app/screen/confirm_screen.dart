import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/app/helper/app_snackbar.dart';
import 'package:vair_app/controller/auth_controller.dart';

class ConfirmScreenController extends GetxController {
  final codeController = TextEditingController();

  var isEnabled = false.obs;

  ConfirmScreenController() : super() {
    codeController.addListener(() {
      isEnabled.value = codeController.text.isNotEmpty;
    });
  }

  @override
  void onClose() {
    codeController.dispose();
    super.onClose();
  }
}

class ConfirmScreen extends StatelessWidget {
  final controller = Get.put(ConfirmScreenController());
  final authController = Get.put(AuthController());

  ConfirmScreen({Key? key}) : super(key: key);

  void _resendCode(String username) async {
    try {
      await Amplify.Auth.resendSignUpCode(username: username);

      Snackbar.info('Confirmation code resent. Check your email');
    } on AuthException catch (e) {
      Snackbar.error(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    var username = Get.arguments[0]['username'];

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                margin: const EdgeInsets.all(30),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      TextField(
                        controller: controller.codeController,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 4.0),
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Enter confirmation code',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(() => MaterialButton(
                            onPressed: controller.isEnabled.value
                                ? () {
                                    authController.confirmUser(
                                        username: username,
                                        confirmationCode:
                                            controller.codeController.text);
                                  }
                                : null,
                            elevation: 4,
                            color: Theme.of(context).primaryColor,
                            disabledColor: Colors.deepPurple.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Text(
                              'VERIFY',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          )),
                      MaterialButton(
                        onPressed: () {
                          _resendCode(username);
                        },
                        child: Text(
                          'Resend code',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

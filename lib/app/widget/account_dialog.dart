import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/controller/auth_controller.dart';

class AccountDialog extends StatelessWidget {
  final _authController = Get.put(AuthController());
  AccountDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
            height: 400,
            child: ListView(
              itemExtent: 35,
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                Obx(() => Text(_authController.authUser.value.username)),
                TextButton(
                    onPressed: () {
                      _authController.signOutCurrentUser();
                    },
                    child: const Text('Logout'))
              ],
            )),
      ),
    );
  }
}

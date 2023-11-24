import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/controllers/auth_controller.dart';

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
                if (_authController.authUser.value?.user?.username != null)
                  Obx(() => Text(
                      _authController.authUser.value?.user?.username ?? "")),
                TextButton(
                    onPressed: () {
                      _authController.signOut();
                      Get.back();
                    },
                    child: const Text('Logout'))
              ],
            )),
      ),
    );
  }
}

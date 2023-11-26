import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/controllers/auth_controller.dart';
import 'package:vair_app/helpers/box.dart';

class ProfileTab extends StatelessWidget {
  final _authController = Get.put(AuthController());
  final box = Box();

  ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        children: [
          if (_authController.authUser.value != null)
            Obx(() => Text(
                _authController.authUser.value?.user?.id.toString() ??
                    'Sign in to see your account detail')),
          Obx(() => Text(_authController.authUser.value?.user?.username ??
              "Unauthorized")),
          Text(box.authUser?.user?.username ?? "Not found")
        ],
      ),
    );
  }
}

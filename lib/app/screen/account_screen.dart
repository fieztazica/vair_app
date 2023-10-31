import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/app/screen/navbar_screen.dart';
import 'package:vair_app/controller/auth_controller.dart';

class AccountScreen extends StatelessWidget {
  var _authController = Get.put(AuthController());

  AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account')),
      body: Obx(() => ListView(
            children: [
              Text(_authController.authUser.value.username),
              TextButton(
                  onPressed: () {
                    _authController.signOutCurrentUser();
                    Get.offAll(() => NavBarScreen());
                  },
                  child: Text('Logout'))
            ],
          )),
    );
  }
}

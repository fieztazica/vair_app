import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/controllers/auth_controller.dart';

import '../screens/edit_profile.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                        'https://cdn.discordapp.com/attachments/1176848867824783361/1178968688821542962/OIP.jpg?ex=65781327&is=65659e27&hm=43d0441711490e1bdfb9564e9b4ed839d61546a6aab4933f834ac57e993d816e&',
                      ),
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(height: 10),
                    if (_authController.authUser.value?.user?.username != null)
                      Obx(() => Text(
                            _authController.authUser.value?.user?.username ??
                                "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          )),
                    if (_authController.authUser.value?.user?.email != null)
                      Obx(() => Text(
                          _authController.authUser.value?.user?.email ?? "")),
                  ],
                ),
              ),
              const Divider(height: 20, thickness: 2),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Settings'),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Change Account'),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => const EditProfileScreen());
                        },
                        child: const Text('Edit Profile'),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          _authController.signOut();
                          Get.back();
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

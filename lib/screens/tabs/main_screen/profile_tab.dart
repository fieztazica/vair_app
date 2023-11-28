import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/controllers/auth_controller.dart';
import 'package:vair_app/helpers/box.dart';
import 'package:vair_app/screens/edit_profile.dart';

class ProfileTab extends StatelessWidget {
  final _authController = Get.find<AuthController>();
  final box = Box();

  ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Obx(() {
        if (_authController.authUser.value != null) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://cdn.discordapp.com/attachments/1176848867824783361/1178968688821542962/OIP.jpg?ex=65781327&is=65659e27&hm=43d0441711490e1bdfb9564e9b4ed839d61546a6aab4933f834ac57e993d816e&',
                    ),
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    _authController.authUser.value?.user?.username ??
                        'Sign in to see your account detail',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    _authController.authUser.value?.user?.email ?? '',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => EditProfileScreen());
                    },
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
            ],
          );
        } else {
          return const Center(
            child: Text("Unauthorized"),
          );
        }
      }),
    );
  }
}

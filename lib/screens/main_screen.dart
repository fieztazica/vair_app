import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/controllers/auth_controller.dart';
import 'package:vair_app/controllers/main_screen_controller.dart';
import 'package:vair_app/routes/app_pages.dart';
import 'package:vair_app/screens/notification_screen.dart';
import 'package:vair_app/widget/account_dialog.dart';

class MainScreen extends StatelessWidget {
  final _logoAssetPath = 'assets/img/vair_logo.png';
  final AuthController _authController = Get.put(AuthController());
  final MainScreenController _controller = Get.put(MainScreenController());

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(() => NavigationBar(
              onDestinationSelected: _controller.onTabTapped,
              selectedIndex: _controller.currentIndex.value,
              destinations: <Widget>[
                const NavigationDestination(
                  selectedIcon: Icon(Icons.home),
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                const NavigationDestination(
                  selectedIcon: Icon(Icons.library_books),
                  icon: Icon(Icons.library_books_outlined),
                  label: 'Library',
                ),
                NavigationDestination(
                  selectedIcon: const Icon(Icons.people),
                  icon: const Icon(Icons.people_outlined),
                  label: _authController.authUser.value != null
                      ? 'Account'
                      : 'Sign In',
                ),
              ],
            )),
        appBar: AppBar(
          title: SizedBox(
            height: 32,
            child: Image.asset(
              _logoAssetPath,
              fit: BoxFit.contain,
              height: 32,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 24,
              ),
              onPressed: () {
                Get.toNamed(Routes.SEARCH);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.notifications,
                size: 24,
              ),
              onPressed: () {
                Get.to(() => const NotificationScreen());
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  size: 24,
                ),
                onPressed: () {
                  if (_authController.authUser.value == null) {
                    Get.toNamed(Routes.SIGNIN);
                  } else {
                    // Get.to(() => AccountScreen());
                    Get.dialog(AccountDialog());
                  }
                },
              ),
            )
          ],
        ),
        body: Navigator(
            key: Get.nestedKey(1),
            initialRoute: Routes.HOME,
            onGenerateRoute: _controller.onGenerateRoute));
  }
}

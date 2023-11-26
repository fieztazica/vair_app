import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/controllers/auth_controller.dart';
import 'package:vair_app/controllers/main_screen_controller.dart';
import 'package:vair_app/routes/app_pages.dart';
import 'package:vair_app/screens/notification_screen.dart';
import 'package:vair_app/widget/account_dialog.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class MainScreen extends StatelessWidget {
  final _logoAssetPath = 'assets/img/vair_logo.png';
  final MainScreenController _controller = Get.find<MainScreenController>();
  final AuthController _authController = Get.find<AuthController>();

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(() => NavigationBar(
              destinations: <Widget>[
                _bottomAppBarItem(
                  icon: Icons.home,
                  page: 0,
                  context,
                  label: "Home",
                ),
                _bottomAppBarItem(
                    icon: Icons.library_books,
                    page: 1,
                    context,
                    label: "Library"),
                _bottomAppBarItem(
                    icon: Icons.people_outlined,
                    page: 2,
                    context,
                    label: _authController.authUser.value != null
                        ? 'Profile'
                        : 'Sign In'),
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
        body: PageView(
          controller: _controller.pageController,
          onPageChanged: _controller.animateToTab,
          physics: const BouncingScrollPhysics(),
          children: [..._controller.pages],
        ));
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page, required label}) {
    return ZoomTapAnimation(
      onTap: () => _controller.goToTab(page),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color:
                  _controller.currentIndex == page ? Colors.teal : Colors.grey,
              size: 20,
            ),
            Text(
              label,
              style: TextStyle(
                  color: _controller.currentIndex == page
                      ? Colors.teal
                      : Colors.grey,
                  fontSize: 13,
                  fontWeight: _controller.currentIndex == page
                      ? FontWeight.w600
                      : null),
            ),
          ],
        ),
      ),
    );
  }
}

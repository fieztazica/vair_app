import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/screen/account_screen.dart';
import 'package:vair_app/pages/home/presentation/views/home_view.dart';
import 'package:vair_app/screen/library_screen.dart';
import 'package:vair_app/screen/notification_screen.dart';
import 'package:vair_app/widget/account_dialog.dart';
import 'package:vair_app/controller/auth_controller.dart';

class TabController extends GetxController {
  var selectedTab = 0.obs;

  void onTabTapped(int index) {
    selectedTab.value = index;
    update();
  }
}

// ignore: must_be_immutable
class NavBarScreen extends StatelessWidget {
  final _logoAssetPath = 'assets/img/vair_logo.png';
  final AuthController _authController = Get.put(AuthController());
  final TabController _tabController = Get.put(TabController());

  List<Widget> tabs = <Widget>[
    const HomeScreen(),
    const LibraryScreen(),
    AccountScreen(),
  ];

  NavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(() => NavigationBar(
              onDestinationSelected: _tabController.onTabTapped,
              selectedIndex: _tabController.selectedTab.value,
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
                  label: _authController.isUserSignedIn.value
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
                Get.toNamed('/search');
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
                  if (_authController.isUserSignedIn.isFalse) {
                    Get.toNamed('/signin');
                  } else {
                    // Get.to(() => AccountScreen());
                    Get.dialog(AccountDialog());
                  }
                },
              ),
            )
          ],
        ),
        body: Obx(() => tabs.elementAt(_tabController.selectedTab.value)));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/app/screen/account_screen.dart';
import 'package:vair_app/app/screen/home_screen.dart';
import 'package:vair_app/app/screen/library_screen.dart';
import 'package:vair_app/app/screen/notification_screen.dart';
import 'package:vair_app/app/screen/search_screen.dart';
import 'package:vair_app/app/screen/signin_screen.dart';
import 'package:vair_app/controller/auth_controller.dart';

class TabController extends GetxController {
  var selectedTab = 0.obs;

  void onTabTapped(int index) {
    selectedTab.value = index;
    update();
  }
}

class NavBarScreen extends StatelessWidget {
  final _logoAssetPath = 'assets/img/vair_logo.png';
  final AuthController _authController = Get.put(AuthController());
  final TabController _tabController = Get.put(TabController());

  List<Widget> tabs = <Widget>[
    HomeScreen(),
    LibraryScreen(),
    AccountScreen(),
  ];

  void init() async {
    try {
      await _authController.getCurrentUser();
      await _authController.fetchIsUserSignedIn();
    } catch (e) {
      Get.snackbar('Vair', "Sign in for full features.");
    }
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Obx(() => Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: _tabController.onTabTapped,
          selectedIndex: _tabController.selectedTab.value,
          destinations: <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.library_books),
              icon: Icon(Icons.library_books_outlined),
              label: 'Library',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.people),
              icon: Icon(Icons.people_outlined),
              label:
                  _authController.isUserSignedIn.value ? 'Account' : 'Sign In',
            ),
          ],
        ),
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
                Get.to(() => NotificationScreen());
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
                    Get.to(() => SigninScreen());
                  } else {
                    Get.to(() => AccountScreen());
                  }
                },
              ),
            )
          ],
        ),
        body: tabs.elementAt(_tabController.selectedTab.value)));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/controllers/auth_controller.dart';
import 'package:vair_app/routes/app_pages.dart';
import 'package:vair_app/screens/account_screen.dart';
import 'package:vair_app/screens/home_screen.dart';
import 'package:vair_app/screens/library_screen.dart';

class MainScreenController extends GetxController {
  final AuthController authController = Get.put(AuthController());
  var currentIndex = 0.obs;

  final pages = <String>[Routes.HOME, Routes.LIBRARY, Routes.ACCOUNT];

  void onTabTapped(int index) {
    currentIndex.value = index;
    String path = pages[index];
    if (path == Routes.ACCOUNT && authController.authUser.value == null) {
      Get.toNamed(Routes.SIGNIN);
    } else {
      Get.toNamed(path, id: 1);
    }
    update();
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == Routes.HOME) {
      return GetPageRoute(
        settings: settings,
        page: () => const HomeScreen(),
      );
    }

    if (settings.name == Routes.LIBRARY) {
      return GetPageRoute(
        settings: settings,
        page: () => const LibraryScreen(),
      );
    }

    if (settings.name == Routes.ACCOUNT) {
      return GetPageRoute(
        settings: settings,
        page: () => AccountScreen(),
      );
    }

    return null;
  }
}

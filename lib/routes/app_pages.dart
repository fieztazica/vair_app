import 'package:get/get.dart';
import 'package:vair_app/bindings/AuthBindings.dart';
import 'package:vair_app/bindings/MainScreenBindings.dart';
import 'package:vair_app/bindings/ProductBindings.dart';
import 'package:vair_app/bindings/RootBindings.dart';
import 'package:vair_app/screens/auth/signin_screen.dart';
import 'package:vair_app/screens/auth/signup_screen.dart';
import 'package:vair_app/screens/main_screen.dart';
import 'package:vair_app/screens/product_detail_screen.dart';
import 'package:vair_app/screens/search_screen.dart';
import 'package:vair_app/screens/settings_screen.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
        name: Routes.MAIN,
        page: () => MainScreen(),
        bindings: [MainScreenBindings(), RootBindings()]),
    GetPage(
      name: Routes.DETAIL,
      page: () => ProductDetailScreen(),
      bindings: [ProductBindings(), AuthBindings()],
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsScreen(),
      bindings: [AuthBindings()],
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => SearchScreen(),
    ),
    GetPage(
        name: Routes.SIGNIN,
        page: () => SigninScreen(),
        bindings: [AuthBindings()]),
    GetPage(
        name: Routes.SIGNUP,
        page: () => SignupScreen(),
        bindings: [AuthBindings()]),
  ];
}

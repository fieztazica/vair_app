import 'package:get/get.dart';
import 'package:vair_app/screens/account_screen.dart';
import 'package:vair_app/screens/auth/signin_screen.dart';
import 'package:vair_app/screens/auth/signup_screen.dart';
import 'package:vair_app/screens/home_screen.dart';
import 'package:vair_app/screens/library_screen.dart';
import 'package:vair_app/screens/navbar_screen.dart';
import 'package:vair_app/screens/product_detail_screen.dart';
import 'package:vair_app/screens/search_screen.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(name: Routes.MAIN, page: () => NavBarScreen(), children: [
      GetPage(name: Routes.HOME, page: () => const HomeScreen()),
      GetPage(name: Routes.LIBRARY, page: () => const LibraryScreen()),
    ]),
    GetPage(
      name: Routes.DETAIL,
      page: () => const ProductDetailScreen(),
    ),
    GetPage(
      name: Routes.ACCOUNT,
      page: () => AccountScreen(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => const SearchScreen(),
    ),
    GetPage(
      name: Routes.SIGNIN,
      page: () => SigninScreen(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => SignupScreen(),
    ),
  ];
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/app/helper/getx_middleware.dart';
import 'package:vair_app/app/screen/navbar_screen.dart';
import 'package:vair_app/app/screen/product_detail_screen.dart';
import 'package:vair_app/app/screen/search_screen.dart';
import 'package:vair_app/app/screen/signin_screen.dart';
import 'package:vair_app/app/screen/signup_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Vair",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => NavBarScreen(),
        ),
        GetPage(name: '/search', page: () => SearchScreen()),
        GetPage(name: '/detail', page: () => ProductDetailScreen()),
        GetPage(
          name: '/signin',
          page: () => SigninScreen(),
          middlewares: [GlobalMiddleware()],
        ),
        GetPage(
          name: '/signup',
          page: () => SignupScreen(),
          middlewares: [GlobalMiddleware()],
        ),
      ],
    );
  }
}

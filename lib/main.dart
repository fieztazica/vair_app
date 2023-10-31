import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/app/helper/amplify_config.dart';
import 'package:vair_app/app/screen/library_screen.dart';
import 'package:vair_app/app/screen/navbar_screen.dart';
import 'package:vair_app/app/screen/notification_screen.dart';
import 'package:vair_app/app/screen/product_detail_screen.dart';
import 'package:vair_app/app/screen/search_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

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
        GetPage(name: '/detail', page: () => ProductDetailScreen())
      ],
    );
  }
}

Future<void> initServices() async {
  print('starting services ...');

  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  await configureAmplify();
  // await Get.putAsync(() => AmplifyService().configureAmplify());
  // await Get.putAsync(SettingsService()).init();
  print('All services started...');
}

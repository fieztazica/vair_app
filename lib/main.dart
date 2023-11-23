import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vair_app/bindings/RootBindings.dart';
import 'package:vair_app/controllers/auth_controller.dart';
import 'package:vair_app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  print('starting services ...');

  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  Get.put(AuthController());
  await GetStorage.init();
  // await Get.putAsync(() => AmplifyService().configureAmplify());
  // await Get.putAsync(SettingsService()).init();
  print('All services started...');
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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: RootBindings(),
    );
  }
}

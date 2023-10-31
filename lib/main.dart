import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/app.dart';
import 'package:vair_app/app/helper/amplify_config.dart';
import 'package:vair_app/controller/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  print('starting services ...');

  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  await configureAmplify();
  Get.put(AuthController());
  // await Get.putAsync(() => AmplifyService().configureAmplify());
  // await Get.putAsync(SettingsService()).init();
  print('All services started...');
}

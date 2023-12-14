import 'package:get/get.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:vair_app/controllers/home_tab_controller.dart';
import 'package:vair_app/models/Product.dart';

class LibraryTabController extends GetxController
    with StateMixin<List<AppInfo>> {
  final HomeTabController homeTabController = Get.put(HomeTabController());

  Iterable<String?> packageNames = const Iterable.empty();

  List<AppInfo> apps = List.empty();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    homeTabController.products.stream.listen((value) {
      if (value != null) {
        packageNames = value.map((e) => e.androidPackageName);
        getInstalledApps();
      }
    });
  }

  getInstalledApps() async {
    change(null, status: RxStatus.loading());
    if (packageNames.isNotEmpty) {
      apps = await InstalledApps.getInstalledApps(true, true);
      apps.removeWhere((element) =>
          packageNames.every((name) => element.packageName! != name));

      apps.isEmpty
          ? change(null, status: RxStatus.empty())
          : change(apps, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error("[Library] Can not fetch products"));
    }
  }

  onAppInfoTapped(String packageName) {
    InstalledApps.startApp(packageName);
  }
}

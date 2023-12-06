import 'package:get/get.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class LibraryTabController extends GetxController
    with StateMixin<List<AppInfo>> {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getInstalledApps();
  }

  getInstalledApps() async {
    change(null, status: RxStatus.loading());
    List<AppInfo> apps = await InstalledApps.getInstalledApps(true, true);
    apps.removeWhere((item) =>
        item.packageName!.contains(RegExp('(vair)|(google)|(android)|(xiaomi)|(.mi.)')));

    if (apps.isEmpty) {
      change(null, status: RxStatus.empty());
    } else {
      change(apps, status: RxStatus.success());
    }
  }

  onAppInfoTapped(String packageName) {
    InstalledApps.startApp(packageName);
  }
}

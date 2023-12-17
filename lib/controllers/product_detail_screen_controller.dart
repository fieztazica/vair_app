import 'dart:developer';
import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vair_app/controllers/library_tab_controller.dart';
import 'package:vair_app/helpers/api_endpoints.dart';
import 'package:vair_app/models/Bought.dart';
import 'package:vair_app/models/Product.dart';
import 'package:vair_app/providers/product_provider.dart';
import 'package:open_filex/open_filex.dart';

class ProductDetailScreenController extends FullLifeCycleController
    with StateMixin<Product>, FullLifeCycleMixin {
  final ProductProvider productProvider = Get.put(ProductProvider());
  var isInstalling = false.obs;
  var isInstalled = false.obs;
  var downloadProgress = 0.obs;
  var downloadStatus = DownloadTaskStatus.undefined.obs;
  var installButtonText = "...".obs;
  Function? onPressed;
  String? taskId;
  var token = RxnString();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    change(null, status: RxStatus.empty());
    token.value = productProvider.box.authUser?.jwt;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getData();
  }

  Future<bool> checkIsInstalled() async {
    if (state == null || state?.androidPackageName == null) return false;
    downloadProgress.value = -1;
    isInstalling.value = true;
    isInstalled.value = false;
    var res =
        await InstalledApps.isAppInstalled(state!.androidPackageName!) ?? false;
    installButtonText.value = res ? "Open" : "Install";
    isInstalled.value = res;
    isInstalling.value = false;
    return res;
  }

  bool checkIsSignedIn() {
    var res = token.value != null;
    if (!res) {
      installButtonText.value = "Sign in to download";
    }
    return res;
  }

  void getData({bool withLoading = true}) async {
    try {
      if (withLoading) {
        change(null, status: RxStatus.loading());
      }
      String? productId = Get.parameters["id"];
      var res = await productProvider.getProducts<Product>(
          "/$productId", Product.fromJson);

      if (res.statusCode == 200 && res.body != null) {
        if (res.body?.data == null) {
          throw "Empty Response";
        }

        change(res.body?.data, status: RxStatus.success());

        var prod = res.body!.data!;

        if (prod.downloadUrl != null) {
          installButtonText.value = prod.price! > 0
              ? '${prod.price!.toStringAsFixed(2)} VND'
              : "Install";
        }

        await checkIsInstalled();

        checkIsSignedIn();
      } else {
        throw res.body?.error?.message ?? "Unknown Error Occurred";
      }
    } catch (e) {
      print(e);
      change(null, status: RxStatus.error("$e"));
    }
  }

  void installClick() async {
    try {
      if (isInstalled.isTrue) {
        InstalledApps.startApp(state!.androidPackageName!);
        return;
      }

      if (taskId != null) {
        var stringTaskId = taskId as String;
        switch (downloadStatus.value) {
          case DownloadTaskStatus.running:
            return;
          case DownloadTaskStatus.failed:
          case DownloadTaskStatus.canceled:
            FlutterDownloader.retry(taskId: stringTaskId);
            return;
          default:
        }
      }

      if (!checkIsSignedIn()) {
        throw "Unauthorized";
      }

      if (status.isSuccess) {
        String productId = Get.parameters["id"]!;
        var res = await productProvider.postProducts<Bought, dynamic>(
            ApiEndPoints.productEndPoints.buy(int.parse(productId)),
            {},
            Bought.fromJson,
            headers: {"Authorization": "Bearer $token"});

        if (res.statusCode == 200) {
          await FlutterDownloader.cancelAll();
          final savedDir = await getDownloadsDirectory();
          taskId = await FlutterDownloader.enqueue(
            url: ApiEndPoints.productEndPoints.download(int.parse(productId)),
            headers: {"Authorization": "Bearer $token"},
            savedDir: savedDir!.absolute.path,
            saveInPublicStorage: true,
            showNotification:
                true, // show download progress in status bar (for Android)
            openFileFromNotification:
                true, // click on notification to open downloaded file (for Android)
          ).then((value) async {
            bool waitTask = true;
            String? filePath;
            while (waitTask) {
              String query = "SELECT * FROM task WHERE task_id='${value!}'";
              var tasks =
                  await FlutterDownloader.loadTasksWithRawQuery(query: query);
              var selectedTask = tasks![0];
              downloadProgress.value = selectedTask.progress;
              downloadStatus.value = selectedTask.status;
              switch (downloadStatus.value) {
                case DownloadTaskStatus.running:
                  isInstalling.value = true;
                  break;
                case DownloadTaskStatus.complete:
                  waitTask = false;
                  isInstalling.value = false;
                  filePath =
                      "/storage/emulated/0/Download/${selectedTask.filename}";
                  break;
                case DownloadTaskStatus.canceled:
                case DownloadTaskStatus.undefined:
                  installButtonText.value = "Install";
                  isInstalling.value = false;
                  break;
                case DownloadTaskStatus.failed:
                  installButtonText.value = "Retry";
                  isInstalling.value = false;
                  break;
                default:
                  break;
              }
            }

            if (waitTask == false) {
              if (await Permission.manageExternalStorage.isDenied) {
                await Permission.manageExternalStorage.request();
              }
              if (filePath != null) {
                var openRes = await OpenFilex.open(filePath);

                if (openRes.type == ResultType.done) {
                  isInstalling.value = true;
                  checkIsInstalled();
                }
              }
            }
          });
        } else {
          throw res.body?.data ?? "Unknown Error";
        }
      } else {
        throw "Product Detail hasn't fetch yet.";
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    change(null, status: RxStatus.empty());
  }

  Future<void> onRefresh() async {
    checkIsInstalled();
    getData();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
    checkIsInstalled();
  }
}

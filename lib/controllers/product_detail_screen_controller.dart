// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vair_app/helpers/api_endpoints.dart';
import 'package:vair_app/models/Bought.dart';
import 'package:vair_app/models/Product.dart';
import 'package:vair_app/providers/product_provider.dart';

class ProductDetailScreenController extends GetxController
    with StateMixin<Product> {
  final ProductProvider productProvider = Get.put(ProductProvider());
  var isDownloading = false.obs;
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
    // FlutterDownloader.registerCallback(handleDownloaderCallback);
    change(null, status: RxStatus.empty());
    getData();

    token.value = productProvider.box.authUser?.jwt;
  }

  void getData() async {
    try {
      change(null, status: RxStatus.loading());
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

        if (token.value == null) {
          installButtonText.value = "Sign in to download";
        }
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
      if (taskId != null) {
        var stringTaskId = taskId as String;
        switch (downloadStatus.value) {
          case DownloadTaskStatus.running:
            FlutterDownloader.cancel(taskId: stringTaskId);
            return;
          case DownloadTaskStatus.failed:
          case DownloadTaskStatus.canceled:
            FlutterDownloader.retry(taskId: stringTaskId);
            return;
          case DownloadTaskStatus.paused:
            FlutterDownloader.resume(taskId: stringTaskId);
            return;
          default:
        }
      }

      if (token.value == null) {
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
          final Directory tempDir = await getApplicationDocumentsDirectory();
          taskId = await FlutterDownloader.enqueue(
            url: ApiEndPoints.productEndPoints.download(int.parse(productId)),
            headers: {"Authorization": "Bearer $token"},
            savedDir: tempDir.absolute.path,
            saveInPublicStorage: true,
            showNotification:
                true, // show download progress in status bar (for Android)
            openFileFromNotification:
                true, // click on notification to open downloaded file (for Android)
          ).then((value) async {
            bool waitTask = true;
            while (waitTask) {
              String query = "SELECT * FROM task WHERE task_id='${value!}'";
              var tasks =
                  await FlutterDownloader.loadTasksWithRawQuery(query: query);
              downloadStatus.value = tasks![0].status;
              downloadProgress.value = tasks[0].progress;
              switch (downloadStatus.value) {
                case DownloadTaskStatus.running:
                  installButtonText.value =
                      "${downloadProgress.value}% (Press to cancel)";
                  if (downloadProgress.value == 100) {
                    installButtonText.value = "Attempting install...";
                  }
                  break;
                case DownloadTaskStatus.complete:
                  waitTask = false;
                  break;
                case DownloadTaskStatus.canceled:
                case DownloadTaskStatus.undefined:
                  installButtonText.value = "Install";
                  break;
                case DownloadTaskStatus.failed:
                  installButtonText.value = "Retry";
                  // FlutterDownloader.remove(taskId: value);
                  break;
                default:
                  break;
              }
            }

            await FlutterDownloader.open(taskId: value!);
          });

          // registerCallback();
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

  onDownloadFinished(String taskId) {
    FlutterDownloader.open(taskId: taskId);
  }
}

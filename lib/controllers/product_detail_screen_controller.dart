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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    change(null, status: RxStatus.empty());
    getData();
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
      if (status.isSuccess) {
        String productId = Get.parameters["id"]!;
        var res = await productProvider.postProducts<Bought, dynamic>(
            ApiEndPoints.productEndPoints.buy(int.parse(productId)),
            {},
            Bought.fromJson);

        if (res.statusCode == 200) {
          final token = productProvider.box.authUser!.jwt!;
          final Directory tempDir = await getTemporaryDirectory();
          final taskId = await FlutterDownloader.enqueue(
            url: ApiEndPoints.productEndPoints.download(int.parse(productId)),
            headers: {"Authorization": token},
            savedDir: tempDir.toString(),
            showNotification:
                true, // show download progress in status bar (for Android)
            openFileFromNotification:
                true, // click on notification to open downloaded file (for Android)
          );

          await FlutterDownloader.registerCallback((id, status, progress) {
            if (taskId != null) {
              onDownloadFinished(taskId);
            }
          });
        } else {
          throw res.body?.error?.message ?? "Unknown Error Occurred";
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

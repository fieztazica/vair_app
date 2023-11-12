import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Snackbar {
  static const defaultMargin = EdgeInsets.only(top: 10, left: 10, right: 10);

  static void error(String message) {
    Get.snackbar("Error", message,
        margin: defaultMargin,
        icon: const Icon(Icons.error),
        backgroundColor: Colors.red,
        colorText: Colors.white);
  }

  static void success(String message) {
    Get.snackbar("Success", message,
        margin: defaultMargin,
        backgroundColor: Colors.green,
        colorText: Colors.white);
  }

  static void normal(String message) {
    Get.snackbar("Vair", message,
        margin: defaultMargin,
        backgroundColor: Colors.teal[100],
        colorText: Colors.black);
  }

  static void info(String message) {
    Get.snackbar("Vair", message,
        icon: const Icon(Icons.info),
        margin: defaultMargin,
        backgroundColor: Colors.blue[100],
        colorText: Colors.black);
  }

  static void warning(String message) {
    Get.snackbar('Warning', message,
        margin: defaultMargin,
        backgroundColor: Colors.yellow,
        colorText: Colors.black,
        icon: const Icon(Icons.warning));
  }
}

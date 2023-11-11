import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/helper/app_snackbar.dart';
import 'package:vair_app/screen/confirm_screen.dart';
import 'package:vair_app/screen/navbar_screen.dart';
import 'package:vair_app/models/UserModel.dart';

class AuthController extends GetxController {
  var isUserSignedIn = false.obs;
  Rxn<UserModel> authUser = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() async {
    try {} on Exception catch (e) {
      print('Error configuring AuthController: $e');
    }
  }
}

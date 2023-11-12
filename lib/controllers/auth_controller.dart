import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/helpers/app_snackbar.dart';
import 'package:vair_app/screens/auth/confirm_screen.dart';
import 'package:vair_app/screens/navbar_screen.dart';
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

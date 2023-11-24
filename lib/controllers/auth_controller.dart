import 'dart:convert';
import 'dart:js_interop';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vair_app/models/AuthUser.dart';
import 'package:vair_app/models/User.dart';
import 'package:vair_app/shared/const_keys.dart';

class AuthController extends GetxController {
  Rxn<AuthUser> authUser = Rxn<AuthUser>();

  Function? disposeListen;

  final box = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    disposeListen = box.listen(() {
      getAuthUser();
    });
  }

  @override
  void onClose() {
    super.onClose();
    disposeListen?.call();
  }

  getAuthUser() {
    var readData = box.read(ConstKeys.authUser.name);
    if (readData != null) {
      Map<String, dynamic> json = Map.from(readData);
      authUser.value = AuthUser.fromJson(json);
    }
    // AuthUser? user =
    //     AuthUser.fromJson();
    // if (user != null) {
    //   authUser.value = user;
    // }
  }

  signOut() {
    box.remove(ConstKeys.authUser.name);
  }

  reset() {
    authUser.value = null;
  }
}

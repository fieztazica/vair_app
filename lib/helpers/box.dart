import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vair_app/controllers/auth_controller.dart';
import 'package:vair_app/models/AuthUser.dart';
import 'package:vair_app/shared/const_keys.dart';

class Box {
  Function? disposeListen;
  final def = GetStorage();

  AuthUser? get authUser {
    var readData = def.read(ConstKeys.authUser.name);
    if (readData != null) {
      Map<String, dynamic> json = Map.from(readData);
      AuthUser parsedData = AuthUser.fromJson(json);
      return parsedData;
    } else {
      return null;
    }
  }

  set setAuthUser(AuthUser data) {
    def.write(ConstKeys.authUser.name, data);
  }

  
}

import 'package:get/get.dart';
import 'package:vair_app/helpers/box.dart';
import 'package:vair_app/models/AuthUser.dart';
import 'package:vair_app/shared/const_keys.dart';

class AuthController extends GetxController {
  Rxn<AuthUser> authUser = Rxn<AuthUser>();

  final box = Box();

  @override
  void onInit() {
    super.onInit();
    box.disposeListen = box.def.listen(() {
      getAuthUserFromBox();
    });
  }

  @override
  void onClose() {
    super.onClose();
    box.disposeListen?.call();
  }

  set setAuthUser(AuthUser data) {
    authUser.value = data;
  }

  getAuthUserFromBox() {
    authUser.value = box.authUser;
    print("getAuthUserFromBox");
    print(authUser.value);
  }

  signOut() {
    box.def.remove(ConstKeys.authUser.name);
  }

  reset() {
    authUser.value = null;
  }
}

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vair_app/models/User.dart';
import 'package:vair_app/shared/const_keys.dart';

class AuthController extends GetxController {
  var isUserSignedIn = false.obs;
  Rxn<User?> authUser = Rxn<Null>();

  final box = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    User? user = box.read(ConstKeys.user.name);
    String? strapiToken = box.read(ConstKeys.strapiToken.name);
    if (user != null) {
      authUser.value = user;
    }
    if (strapiToken != null && strapiToken.isNotEmpty) {
      isUserSignedIn.value = true;
    }
  }
}

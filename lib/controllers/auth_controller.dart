import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vair_app/models/User.dart';

class AuthController extends GetxController {
  var isUserSignedIn = false.obs;
  Rxn<User> authUser = Rxn<User>();

  final box = GetStorage();

  
}

import 'package:get_storage/get_storage.dart';
import 'package:vair_app/helpers/app_converter.dart';
import 'package:vair_app/models/AuthUser.dart';
import 'package:vair_app/shared/const_keys.dart';

class Box {
  Function? disposeListen;
  final def = GetStorage();

  AuthUser? get authUser =>
      AppConverter.convertAuthUser(def.read(ConstKeys.authUser.name));

  set setAuthUser(AuthUser data) {
    def.write(ConstKeys.authUser.name, data);
  }
}

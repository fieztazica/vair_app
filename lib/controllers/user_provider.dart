import 'package:get_storage/get_storage.dart';
import 'package:vair_app/models/StrapiRes.dart';
import 'package:vair_app/models/User.dart';
import 'package:vair_app/shared/GetBaseProvider.dart';
import 'package:vair_app/shared/const_keys.dart';

class UserProvider extends GetBaseProvider {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = '${GetBaseProvider.strapiBaseApiURL}/users';

    super.addResponseModifier<User>(strapiRes: false);
    super.addAuthenticator();
  }
}

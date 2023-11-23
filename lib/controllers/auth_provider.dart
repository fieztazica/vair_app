import 'package:vair_app/models/AuthUser.dart';
import 'package:vair_app/shared/GetBaseProvider.dart';

class AuthProvider extends GetBaseProvider {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = AuthUser.fromJson as dynamic;
    httpClient.baseUrl = '${GetBaseProvider.strapiBaseApiURL}/auth';

    super.addResponseModifier<AuthUser>(strapiRes: false);
  }
}

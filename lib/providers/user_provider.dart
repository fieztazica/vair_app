import 'package:vair_app/helpers/api_endpoints.dart';
import 'package:vair_app/models/User.dart';
import 'package:vair_app/shared/GetBaseProvider.dart';

class UserProvider extends GetBaseProvider {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = '${ApiEndPoints.strapiBaseApiURL}/users';

    super.addResponseModifier<User>(strapiRes: false);
    super.addAuthenticator();
  }
}

import 'package:amplify_flutter/amplify_flutter.dart';

class AuthApi {
  static Future<bool> isUserSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    return result.isSignedIn;
  }

  static Future<AuthUser> getCurrentUser() async {
    final user = await Amplify.Auth.getCurrentUser();
    return user;
  }

  static Future<void> rememberCurrentDevice() async {
    try {
      await Amplify.Auth.rememberDevice();
      safePrint('Remember device succeeded');
    } on AuthException catch (e) {
      safePrint('Remember device failed with error: $e');
    }
  }
}

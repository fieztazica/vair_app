import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isUserSignedIn = false.obs;
  Rx<AuthUser> authUser =
      AuthUser(userId: '', username: '', signInDetails: SelfSignInDetails())
          .obs;

  Future<AuthUser> getCurrentUser() async {
    final user = await Amplify.Auth.getCurrentUser();
    authUser.value = user;
    return user;
  }

  Future<bool> fetchIsUserSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    isUserSignedIn.value = result.isSignedIn;
    return result.isSignedIn;
  }

  Future<void> signOutCurrentUser() async {
    final result = await Amplify.Auth.signOut();
    if (result is CognitoCompleteSignOut) {
      isUserSignedIn.value = false;
      authUser.refresh();
      safePrint('Sign out completed successfully');
    } else if (result is CognitoFailedSignOut) {
      safePrint('Error signing user out: ${result.exception.message}');
    }
  }
}

class SelfSignInDetails extends SignInDetails {
  @override
  Map<String, Object?> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

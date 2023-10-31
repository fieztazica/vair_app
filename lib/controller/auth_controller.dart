import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/app/helper/app_snackbar.dart';
import 'package:vair_app/app/screen/confirm_screen.dart';
import 'package:vair_app/app/screen/navbar_screen.dart';

class AuthController extends GetxController {
  var isUserSignedIn = false.obs;
  Rx<AuthUser> authUser =
      AuthUser(userId: '', username: '', signInDetails: SelfSignInDetails())
          .obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() async {
    try {
      await getCurrentUser();
      await fetchIsUserSignedIn();
    } on Exception catch (e) {
      safePrint('Error configuring AuthController: $e');
    }
  }

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
      Snackbar.success('Sign out completed successfully.');
    } else if (result is CognitoFailedSignOut) {
      Snackbar.error('Error signing user out: ${result.exception.message}');
    }
    Get.offAll(() => NavBarScreen());
  }

  Future<void> signInUser(String username, String password) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      await _handleSignInResult(result, username);
    } on AuthException catch (e) {
      Snackbar.error('Error signing in: ${e.message}');
    }
  }

  Future<void> _handleSignInResult(SignInResult result, String username) async {
    switch (result.nextStep.signInStep) {
      case AuthSignInStep.confirmSignInWithSmsMfaCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthSignInStep.confirmSignInWithNewPassword:
        safePrint('Enter a new password to continue signing in');
        break;
      case AuthSignInStep.confirmSignInWithCustomChallenge:
        final parameters = result.nextStep.additionalInfo;
        final prompt = parameters['prompt']!;
        safePrint(prompt);
        break;
      case AuthSignInStep.resetPassword:
        final resetResult = await Amplify.Auth.resetPassword(
          username: username,
        );
        await _handleResetPasswordResult(resetResult);
        break;
      case AuthSignInStep.confirmSignUp:
        // Resend the sign up code to the registered device.
        final resendResult = await Amplify.Auth.resendSignUpCode(
          username: username,
        );
        _handleCodeDelivery(resendResult.codeDeliveryDetails);
        Get.to(() => ConfirmScreen(), arguments: [
          {'username': username}
        ]);
        break;
      case AuthSignInStep.done:
        Get.snackbar("Vair", "Welcome back, $username!");
        Get.offAll(() => NavBarScreen());
        fetchIsUserSignedIn();
        getCurrentUser();
        break;
      default:
        Get.snackbar("Vair", "Something's wrong!",
            backgroundColor: Colors.red, colorText: Colors.white);
        break;
    }
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    Snackbar.info(
        'A confirmation code has been sent to ${codeDeliveryDetails.destination}. Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.');
  }

  Future<void> resetPassword(String username) async {
    try {
      final result = await Amplify.Auth.resetPassword(
        username: username,
      );
      await _handleResetPasswordResult(result);
    } on AuthException catch (e) {
      safePrint('Error resetting password: ${e.message}');
    }
  }

  Future<void> _handleResetPasswordResult(ResetPasswordResult result) async {
    switch (result.nextStep.updateStep) {
      case AuthResetPasswordStep.confirmResetPasswordWithCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthResetPasswordStep.done:
        safePrint('Successfully reset password');
        break;
    }
  }

  Future<void> confirmResetPassword({
    required String username,
    required String newPassword,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmResetPassword(
        username: username,
        newPassword: newPassword,
        confirmationCode: confirmationCode,
      );
      safePrint('Password reset complete: ${result.isPasswordReset}');
    } on AuthException catch (e) {
      safePrint('Error resetting password: ${e.message}');
    }
  }

  Future<void> signUpUser({
    required String username,
    required String password,
    required String email,
    String? phoneNumber,
  }) async {
    try {
      final userAttributes = {
        AuthUserAttributeKey.email: email,
        if (phoneNumber != null) AuthUserAttributeKey.phoneNumber: phoneNumber,
        // additional attributes as needed
      };
      final result = await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: SignUpOptions(
          userAttributes: userAttributes,
        ),
      );
      await _handleSignUpResult(result, username);
    } on AuthException catch (e) {
      Snackbar.error('Error signing up user: ${e.message}');
    }
  }

  Future<void> _handleSignUpResult(SignUpResult result, String username) async {
    switch (result.nextStep.signUpStep) {
      case AuthSignUpStep.confirmSignUp:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        Get.to(() => ConfirmScreen(), arguments: [
          {'username': username}
        ]);
        break;
      case AuthSignUpStep.done:
        Get.offAllNamed('/signin');
        Snackbar.success('Sign up is complete. Please sign in!');
        break;
    }
  }

  Future<void> confirmUser({
    required String username,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );
      // Check if further confirmations are needed or if
      // the sign up is complete.
      await _handleSignUpResult(result, username);
    } on AuthException catch (e) {
      Snackbar.error('Error confirming user: ${e.message}');
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

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  late SignupData _data;
  bool _isSignedIn = false;

  Future<String?>? _onLogin(LoginData data) async {
    try {
      final res = await Amplify.Auth.signIn(
        username: data.name,
        password: data.password,
      );

      _isSignedIn = res.isSignedIn;
    } on AuthException catch (e) {
      if (e.message.contains('already a user which is signed in')) {
        await Amplify.Auth.signOut();
        return 'Problem logging in. Please try again.';
      }

      return '${e.message} - ${e.recoverySuggestion}';
    }
  }

  Future<String?>? _onRecoverPassword(
      BuildContext context, String email) async {
    try {
      final res = await Amplify.Auth.resetPassword(username: email);

      if (res.nextStep.updateStep == 'CONFIRM_RESET_PASSWORD_WITH_CODE') {
        Navigator.pushReplacementNamed(
          context,
          '/confirm-reset',
          arguments: LoginData(name: email, password: ''),
        );
      }
    } on AuthException catch (e) {
      return '${e.message} - ${e.recoverySuggestion}';
    }
  }

  Future<String?>? _onSignup(SignupData data) async {
    try {
      if (data.name != null && data.password != null) {
        await Amplify.Auth.signUp(
            username: data.name!,
            password: data.password!,
            options: SignUpOptions(
                userAttributes: {AuthUserAttributeKey.email: data.name!}));

        _data = data;
      }
    } on AuthException catch (e) {
      return '${e.message} - ${e.recoverySuggestion}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Welcome',
      onLogin: _onLogin,
      onRecoverPassword: (String email) => _onRecoverPassword(context, email),
      onSignup: _onSignup,
      theme: LoginTheme(
          primaryColor: Theme.of(context).primaryColor,
          cardTheme: Theme.of(context).cardTheme),
      onSubmitAnimationCompleted: () {
        Navigator.pushReplacementNamed(
          context,
          _isSignedIn ? '/' : '/confirm',
          arguments: _data,
        );
      },
    );
  }
}

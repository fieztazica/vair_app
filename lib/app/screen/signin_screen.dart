import 'package:flutter/material.dart';
import 'package:vair_app/app/widget/auth_form.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: const Center(child: AuthForm()),
    );
  }
}

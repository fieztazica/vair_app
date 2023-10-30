import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:vair_app/app/screen/navbar_screen.dart';
import 'package:vair_app/app/screen/signin_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isUserSignedIn = false;
  bool fetched = false;

  Future<void> fetchIsUserSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    setState(() {
      isUserSignedIn = result.isSignedIn;
      fetched = true;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchIsUserSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: fetched
            ? isUserSignedIn
                ? const NavBarScreen()
                : const SigninScreen()
            : const FlutterLogo(
                size: 100.0), // Use any widget or image as a logo
      ),
    );
  }
}

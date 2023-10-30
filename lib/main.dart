import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:vair_app/app/helper/amplify_config.dart';
import 'package:vair_app/app/screen/confirm_reset_screen.dart';
import 'package:vair_app/app/screen/confirm_screen.dart';
import 'package:vair_app/app/screen/signin_screen.dart';
import 'package:vair_app/app/screen/navbar_screen.dart';
import 'package:vair_app/app/screen/product_detail_screen.dart';
import 'package:vair_app/app/screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
        signUpForm: SignUpForm.custom(
          fields: [
            SignUpFormField.username(),
            SignUpFormField.email(required: true),
            SignUpFormField.password(),
            SignUpFormField.passwordConfirmation(),
          ],
        ),
        child: MaterialApp(
          title: "Vair",
          initialRoute: "/",
          builder: Authenticator.builder(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,

            // Define the default brightness and colors.
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              brightness: Brightness.light,
            ),
          ),
          routes: {
            '/': (context) => const SplashScreen(),
            '/details': (context) =>
                const AuthenticatedView(child: ProductDetailScreen()),
          },
        ));
  }
}

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:
            FlutterLogo(size: 100.0), // Use any widget or image as a logo
      ),
    );
  }
}

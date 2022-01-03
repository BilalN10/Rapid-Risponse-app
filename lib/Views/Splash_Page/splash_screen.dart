import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_response/Views/Authentication/sign_screen.dart';
import 'package:rapid_response/Views/Root/root.dart';

class SplashScreen extends StatefulWidget {
  // static String tag = 'splash-page';

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(() => const Root());
      // OneContext().pushNamedAndRemoveUntil(Routes.signin_screen, (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}

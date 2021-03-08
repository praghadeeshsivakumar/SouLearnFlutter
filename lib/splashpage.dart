import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'loginpage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      backgroundColor: Colors.white,
      seconds: 3,
      photoSize: 150,
      loaderColor: Colors.blue,
      image: ((Image.asset('assets/images/learnable.png'))),
      navigateAfterSeconds: LoginPage(),
    );
  }
}
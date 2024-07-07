import 'dart:async';

import 'package:flutter/material.dart';
import 'onboarding1.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnboardingScreen1()));
    });
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFAFC8AD),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/splashscreen.jpg',height: 400,)
                ],
              )
            ],
          ),
        )
    );
  }
}

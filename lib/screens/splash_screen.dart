import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:netflix_clone/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3, milliseconds: 500), 
      (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset("lib/assets/netflix.json"),
    );
  }
}
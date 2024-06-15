import 'package:flutter/material.dart';
import 'package:netflix_clone/pages/onboarding_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Hello World!, elmarsmn gey, cart"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => OnboardingScreen()))),
    );
  }
}

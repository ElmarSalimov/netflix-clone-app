import 'package:flutter/material.dart';
import 'package:netflix_clone/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  final Widget child;
  const HomeScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: child,
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
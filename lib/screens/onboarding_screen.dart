import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_clone/widgets/last_onboarding_tile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:netflix_clone/widgets/onboarding_tile.dart';

class OnboardingScreen extends StatelessWidget {
  final controller = PageController();

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      // Netflix icon and Privacy and Help tab
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: const EdgeInsets.only(left: 20),
          child: Image.asset(
            'lib/assets/netflix-icon.png',
          ),
        ),
        leadingWidth: 120,

        actions: const [
          Text("Privacy",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          SizedBox(
            width: 15,
          ),
          Text("Help",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      
      body: Stack(
        children: [
          // Main Screen
          PageView(
            controller: controller,
            children: const [
              OnboardingTile(
                  imagePath: 'lib/assets/1.jpeg',
                  mainText: "Watch everywhere",
                  secondText: "Stream on phone, tablet, laptop and TV."),
              OnboardingTile(
                  imagePath: 'lib/assets/2.jpeg',
                  mainText: "There's a plan for every fan",
                  secondText: "Small price. Big entertainment."),
              OnboardingTile(
                  imagePath: 'lib/assets/3.jpeg',
                  mainText: "Cancel online anytime",
                  secondText: "Join today, no reason to wait."),
              LastOnboardingTile(
                  imagePath: 'lib/assets/netflix-wallpaper.jpg',
                  mainText: "How do I watch?",
                  secondText:
                      "Members that subscribe to Netflix can watch here in the app.")
            ],
          ),

          // Smooth page indicator and Sign-in
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 80),
              padding: const EdgeInsets.all(8.0),
              child: SmoothPageIndicator(
                controller: controller,
                count: 4,
                effect: const ScrollingDotsEffect(
                  activeDotColor: Colors.red,
                  activeDotScale: 1,
                  dotWidth: 8,
                  dotHeight: 8,
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                context.go('/loginScreen');
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                height: 50,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 17, 0),
                    borderRadius: BorderRadius.circular(4)),
                child: const Center(
                  child: Text("SIGN IN",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

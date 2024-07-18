import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LastOnboardingTile extends StatelessWidget {
  final String imagePath;
  final String mainText;
  final String secondText;

  const LastOnboardingTile(
      {super.key,
      required this.imagePath,
      required this.mainText,
      required this.secondText});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [

      // Note: add little bit fade effect to the image
      Image.asset(
        imagePath,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(mainText,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 34)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Text(secondText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 20)),
                const SizedBox(
                  height: 16,
                ),
                const Text("Create a netflix account and more at",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                GestureDetector(
                  onTap: () => launchUrl(Uri.parse('https://netflix.com')),
                  child: const Text("netflix.com/more",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 20)),
                ),
              ],
            ),
          ),
        ],
      )
    ]);
  }
}

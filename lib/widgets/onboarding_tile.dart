import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingTile extends StatelessWidget {
  final String imagePath;
  final String mainText;
  final String secondText;

  const OnboardingTile(
      {super.key,
      required this.imagePath,
      required this.mainText,
      required this.secondText});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath),
            Text(mainText,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Text(secondText,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Create a netflix account and more at",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18)),
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
        ));
  }
}

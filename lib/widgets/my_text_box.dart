import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MyTextBox extends StatelessWidget {
  final String topText;
  final String mainText;

  final void Function()? onPressed;

  const MyTextBox(
      {super.key,
      required this.topText,
      required this.onPressed,
      required this.mainText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    topText,
                    style: GoogleFonts.openSans(
                        textStyle:
                            TextStyle(fontSize: 18, color: Colors.grey.shade400)),
                  ),
                  IconButton(
                      onPressed: onPressed, icon: const Icon(LucideIcons.settings, color: Colors.grey,))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(mainText,
                      style: GoogleFonts.openSans(
                          textStyle:
                              const TextStyle(fontSize: 16, color: Colors.white))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

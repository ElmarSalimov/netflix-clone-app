import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final controller;
  const MyAppBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black.withAlpha(200),
      elevation: 0,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("For You", style: TextStyle(color: Colors.white)),
      ),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(25),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 35,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: TabBar(
                    controller: controller,
                    dividerColor: Colors.transparent,
                    automaticIndicatorColorAdjustment: true,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade800),
                    tabs: [
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Movies",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("TV Shows",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )),
                        ),
                      ),
                    ]),
              ),
            ),
          )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

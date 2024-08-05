import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewAndHotBar extends SliverPersistentHeaderDelegate {
  @override
  final double minExtent;

  @override
  final double maxExtent;

  bool isFirst;
  bool isSecond;
  final void Function(bool isFirst) onFilterChanged;

  NewAndHotBar({
    required this.minExtent,
    required this.maxExtent,
    required this.isFirst,
    required this.isSecond,
    required this.onFilterChanged,
    
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // Background content
        Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
        ),

        // Foreground content
        Column(
          children: [
            // Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("New & Hot",
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ))),
                ],
              ),
            ),

            // Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    onFilterChanged(true);
                  },
                  child: AnimatedContainer(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                        color: isFirst ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            "🍿",
                          ),
                          Text("Coming Soon",
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      color: isFirst
                                          ? Colors.black
                                          : Colors.white))),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onFilterChanged(false);
                  },
                  child: AnimatedContainer(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                        color: isSecond ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            "🔥",
                          ),
                          Text("Everyone's Watching",
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      color: isFirst
                                          ? Colors.white
                                          : Colors.black))),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

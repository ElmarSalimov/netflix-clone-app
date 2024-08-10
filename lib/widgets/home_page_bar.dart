import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:netflix_clone/provider/page_provider.dart';
import 'package:provider/provider.dart';

class HomePageBar extends SliverPersistentHeaderDelegate {
  @override
  final double minExtent;

  @override
  final double maxExtent;

  bool isMovie;
  bool isTvShow;
  final void Function(bool isMovie) onFilterChanged;

  HomePageBar({
    required this.minExtent,
    required this.maxExtent,
    required this.isMovie,
    required this.isTvShow,
    required this.onFilterChanged,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final pageProvider = Provider.of<PageProvider>(context, listen: false);
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // Background content
        Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                color: Colors.black.withAlpha(200),
              ),
            ),
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
                  Text("For You",
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ))),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(LucideIcons.cast),
                        onPressed: () {},
                        color: Colors.white,
                      ),
                      IconButton(
                        icon: const Icon(LucideIcons.user),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        color: Colors.white,
                      ),
                    ],
                  )
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
                        color: isMovie ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Movies",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  color:
                                      isMovie ? Colors.black : Colors.white))),
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
                        color: isTvShow ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("TV Shows",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  color:
                                      isTvShow ? Colors.black : Colors.white))),
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

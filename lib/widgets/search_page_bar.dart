import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:netflix_clone/provider/page_provider.dart';
import 'package:provider/provider.dart';

class SearchPageBar extends SliverPersistentHeaderDelegate {
  @override
  final double minExtent;

  @override
  final double maxExtent;
  final TextEditingController controller;

  SearchPageBar({
    required this.minExtent,
    required this.maxExtent,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
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
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    pageProvider.setIndex(0);
                    context.go('/homePage');
                  },
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                const SizedBox(width: 8),
                const Icon(LucideIcons.search, color: Colors.white),
                const SizedBox(width: 8),
                Flexible(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: GoogleFonts.lato(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                    style: GoogleFonts.lato(color: Colors.white),
                    cursorColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

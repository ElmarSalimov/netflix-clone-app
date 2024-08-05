import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:netflix_clone/pages/home_page.dart';
import 'package:netflix_clone/pages/new_and_hot_page.dart';
import 'package:netflix_clone/pages/search_page.dart';
import 'package:netflix_clone/provider/page_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    SearchPage(),
    NewAndHotPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Consumer<PageProvider>(
          builder: (context, pageProvider, child) {
            return IndexedStack(
              index: pageProvider.selectedIndex,
              children: _pages,
            );
          },
        ),
      ),
      bottomNavigationBar: Consumer<PageProvider>(
        builder: (context, pageProvider, child) {
          return BottomNavigationBar(
            backgroundColor: Colors.grey[900],
            unselectedItemColor: const Color(0xFF7A777A),
            selectedItemColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(LucideIcons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(LucideIcons.search), label: "Search"),
              BottomNavigationBarItem(
                  icon: Icon(
                    LucideIcons.playSquare,
                  ),
                  label: "New & Hot"),
            ],
            currentIndex: pageProvider.selectedIndex,
            onTap: (index) {
              pageProvider.setIndex(index);
            },
          );
        },
      ),
    );
  }
}

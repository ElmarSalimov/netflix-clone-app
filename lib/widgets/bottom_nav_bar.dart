import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_clone/provider/page_provider.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
      builder: (context, pageProvider, child) {
        return BottomNavigationBar(
          backgroundColor: Colors.grey[900],
          unselectedItemColor: const Color(0xFF7A777A),
          selectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.man), label: "User"),
          ],
          currentIndex: pageProvider.selectedIndex,
          onTap: (index) {
            pageProvider.setIndex(index);
            switch (index) {
              case 0:
                context.go('/homePage');
                break;
              case 1:
                context.go('/searchPage');
                break;
              case 2:
                context.go('/profilePage');
                break;
            }
          },
        );
      },
    );
  }
}

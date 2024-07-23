import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentPage = 0;
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.man), label: "User"),
      ],
      currentIndex: currentPage,
      onTap: (index) {

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

        setState(() {
          currentPage = index;
        });
      },
    );
  }
}

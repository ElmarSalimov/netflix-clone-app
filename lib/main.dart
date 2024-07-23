import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_clone/pages/home_page.dart';
import 'package:netflix_clone/pages/profile_page.dart';
import 'package:netflix_clone/pages/search_page.dart';
import 'package:netflix_clone/provider/movie_provider.dart';
import 'package:netflix_clone/screens/home_screen.dart';
import 'package:netflix_clone/screens/login_screen.dart';
import 'package:netflix_clone/screens/onboarding_screen.dart';
import 'package:netflix_clone/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/splashScreen',
  routes: [
    GoRoute(
      path: '/splashScreen',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboardingScreen',
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      path: '/loginScreen',
      builder: (context, state) => const LoginScreen(),
    ),
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        return HomeScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/homePage',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/searchPage',
          builder: (context, state) => const SearchPage(),
        ),
        GoRoute(
          path: '/profilePage',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

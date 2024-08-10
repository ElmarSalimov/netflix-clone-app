import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_clone/pages/home_page.dart';
import 'package:netflix_clone/pages/new_and_hot_page.dart';
import 'package:netflix_clone/pages/search_page.dart';
import 'package:netflix_clone/provider/movie_provider.dart';
import 'package:netflix_clone/provider/page_provider.dart';
import 'package:netflix_clone/screens/home_screen.dart';
import 'package:netflix_clone/screens/main_screen.dart';
import 'package:netflix_clone/screens/onboarding_screen.dart';
import 'package:netflix_clone/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      path: '/mainScreen',
      builder: (context, state) => const MainScreen(),
    ),
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        return HomeScreen();
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
          builder: (context, state) => const NewAndHotPage(),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

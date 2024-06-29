import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:netflix_clone/models/upcoming_movie.dart';
import 'package:netflix_clone/pages/onboarding_screen.dart';
import 'package:netflix_clone/services/api.dart';
import 'package:netflix_clone/widgets/movie_slide.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<UpcomingMovie> getUpcomingMovie;
  ApiService apiServices = ApiService();

  @override
  void initState() {
    super.initState();
    getUpcomingMovie = apiServices.getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Remove the back button
          automaticallyImplyLeading: false,
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: getUpcomingMovie,
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return MovieSlide(
                        future: getUpcomingMovie, headlineText: "Upcoming");
                  }))
            ],
          ),
        )

        // floatingActionButton: FloatingActionButton(
        //     onPressed: () => Navigator.of(context).push(
        //         MaterialPageRoute(builder: (context) => OnboardingScreen()))),
        );
  }
}

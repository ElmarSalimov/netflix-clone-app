import 'package:flutter/material.dart';
import 'package:netflix_clone/models/upcoming_movie.dart';
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
      body: SingleChildScrollView(
        child: Column(
            children: [
              
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 220,
                child: UpcomingMovieCard(
                  future: getUpcomingMovie,
                  headlineText: 'Upcoming Movies',
                ),
              ),
              
              const SizedBox(
                height: 20,
              ),
              const Center(child: Text("Hello world!"),)
            ],
          ),
      ),
      );
  }
}

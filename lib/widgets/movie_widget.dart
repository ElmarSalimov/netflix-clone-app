import 'package:flutter/material.dart';
import 'package:netflix_clone/provider/movie_provider.dart';
import 'package:netflix_clone/widgets/slide.dart';
import 'package:provider/provider.dart';

class MovieWidget extends StatefulWidget {
  const MovieWidget({super.key});

  @override
  _MovieWidgetState createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget>
    with AutomaticKeepAliveClientMixin<MovieWidget> {
  @override
  bool get wantKeepAlive => true;
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      controller: controller,
      child: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) => Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Slide(
              list: movieProvider.upcomingMovies,
              headlineText: "Upcoming",
              type: "Movie",
              controller: movieProvider.upcomingController,
            ),
            const SizedBox(height: 10),
            Slide(
                list: movieProvider.popularMovies,
                headlineText: "Popular",
                type: "Movie",
                controller: movieProvider.popularController),
            const SizedBox(height: 10),
            Slide(
                list: movieProvider.topRatedMovies,
                headlineText: "Top Rated",
                type: "Movie",
                controller: movieProvider.topRatedController),
            const SizedBox(height: 10),
            Slide(
                list: movieProvider.nowPlayingMovies,
                headlineText: "Now Playing",
                type: "Movie",
                controller: movieProvider.nowPlayingController),
            const SizedBox(height: 10),
            Slide(
                list: movieProvider.actionMovies,
                headlineText: "Action",
                type: "Movie",
                controller: movieProvider.actionController),
          ],
        ),
      ),
    );
  }
}

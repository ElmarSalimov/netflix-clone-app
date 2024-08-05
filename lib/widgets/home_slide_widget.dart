import 'package:flutter/material.dart';
import 'package:netflix_clone/provider/movie_provider.dart';
import 'package:netflix_clone/widgets/home_slide.dart';
import 'package:provider/provider.dart';

class SlideWidget extends StatefulWidget {
  const SlideWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SlideWidgetState createState() => _SlideWidgetState();
}

class _SlideWidgetState extends State<SlideWidget>
    with AutomaticKeepAliveClientMixin<SlideWidget> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<MovieProvider>(
      builder: (context, movieProvider, child) => Column(
        children: [
          HomeSlide(
              list: movieProvider.popularMovies,
              headlineText: "Popular",
              type: "Movie",
              controller: movieProvider.popularController),
          const SizedBox(height: 10),
          HomeSlide(
              list: movieProvider.topRatedMovies,
              headlineText: "Top Rated",
              type: "Movie",
              controller: movieProvider.topRatedController),
          const SizedBox(height: 10),
          HomeSlide(
              list: movieProvider.actionMovies,
              headlineText: "Action",
              type: "Movie",
              controller: movieProvider.actionController),
          const SizedBox(height: 10),
          HomeSlide(
            list: movieProvider.airingTvShows,
            headlineText: "On The Air",
            type: "TvShow",
            controller: movieProvider.airingTvController,
          ),
          const SizedBox(height: 10),
          HomeSlide(
            list: movieProvider.dramaTvShows,
            headlineText: "Drama",
            type: "TvShow",
            controller: movieProvider.dramaTvController,
          ),
          const SizedBox(height: 10),
          HomeSlide(
            list: movieProvider.animationTvShows,
            headlineText: "Animation",
            type: "TvShow",
            controller: movieProvider.animationTvController,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:netflix_clone/provider/movie_provider.dart';
import 'package:netflix_clone/widgets/slide.dart';
import 'package:provider/provider.dart';

class SlideWidget extends StatefulWidget {
  const SlideWidget({super.key});

  @override
  _SlideWidgetState createState() => _SlideWidgetState();
}

class _SlideWidgetState extends State<SlideWidget>
    with AutomaticKeepAliveClientMixin<SlideWidget> {
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
              list: movieProvider.popularTvShows,
              headlineText: "Popular",
              type: "TvShow",
              controller: movieProvider.popularTvController,
            ),
            const SizedBox(height: 10),
            Slide(
              list: movieProvider.topRatedTvShows,
              headlineText: "Top Rated",
              type: "TvShow",
              controller: movieProvider.topRatedTvController,
            ),
            const SizedBox(height: 10),
            Slide(
              list: movieProvider.airingTvShows,
              headlineText: "On The Air",
              type: "TvShow",
              controller: movieProvider.airingTvController,
            ),
            const SizedBox(height: 10),
            Slide(
              list: movieProvider.dramaTvShows,
              headlineText: "Drama",
              type: "TvShow",
              controller: movieProvider.dramaTvController,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:netflix_clone/provider/movie_provider.dart';
import 'package:netflix_clone/widgets/slide.dart';
import 'package:provider/provider.dart';

class TvShowWidget extends StatefulWidget {
  const TvShowWidget({super.key});

  @override
  _TvShowWidgetState createState() => _TvShowWidgetState();
}

class _TvShowWidgetState extends State<TvShowWidget>
    with AutomaticKeepAliveClientMixin<TvShowWidget> {
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
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

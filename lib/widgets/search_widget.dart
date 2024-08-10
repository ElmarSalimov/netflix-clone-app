import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/models/movie.dart';
import 'package:netflix_clone/models/search_model.dart';
import 'package:netflix_clone/provider/movie_provider.dart';
import 'package:netflix_clone/util/constants.dart';
import 'package:netflix_clone/widgets/movie_detail_widget.dart';
import 'package:netflix_clone/widgets/tv_detail_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SearchWidget extends StatefulWidget {
  final TextEditingController controller;
  final Future<SearchModel>? movieSearchResults;
  final Future<SearchModel>? tvShowSearchResults;
  final ScrollController scrollController = ScrollController();
  final ScrollController scrollController2 = ScrollController();

  SearchWidget({
    super.key,
    required this.controller,
    required this.movieSearchResults,
    required this.tvShowSearchResults,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    final List<Movie> movies =
        Provider.of<MovieProvider>(context, listen: false).topSearches;
    return widget.controller.text.isEmpty
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text("Top Searches",
                        style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                fontSize: 18, color: Colors.white))),
                  ),
                ],
              ),
              ListView.builder(
                controller: widget.scrollController2,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: movies.length,
                itemBuilder: (BuildContext context, int index) {
                  final result = movies[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MovieDetailWidget(
                                movieId: result.id!,
                                movie: movies[index],
                              )));
                    },
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 4),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                '$imageUrl${result.posterPath}',
                                width: 70,
                                height: 105,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: 70,
                                  height: 105,
                                  color: Colors.black,
                                  child: const Center(
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(result.title!,
                                  style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                          fontSize: 15, color: Colors.white))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          )
        : SingleChildScrollView(
            controller: widget.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<SearchModel>(
                  future: widget.movieSearchResults,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildShimmerPlaceholder();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!.results!.isEmpty) {
                      return const Center(
                        child: Text(
                          'No movie results found',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      final moviesWithPoster = snapshot.data!.results!
                          .where((movie) => movie.posterPath != null)
                          .toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Movies',
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontSize: 18, color: Colors.white)),
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: moviesWithPoster.length > 9
                                ? 9
                                : moviesWithPoster.length,
                            itemBuilder: (context, index) {
                              final movie = moviesWithPoster[index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailWidget(
                                        movieId: movie.id!,
                                        movie: movie.toMovie(),
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.network(
                                      '$imageUrl${movie.posterPath}',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 150,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                        width: double.infinity,
                                        height: 150,
                                        color: Colors.black,
                                        child: const Center(
                                          child: Icon(
                                            Icons.image,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }
                  },
                ),
                FutureBuilder<SearchModel>(
                  future: widget.tvShowSearchResults,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildShimmerPlaceholder();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!.results!.isEmpty) {
                      return const Center(
                        child: Text(
                          'No TV show results found',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      final tvShowsWithPoster = snapshot.data!.results!
                          .where((tvShow) => tvShow.posterPath != null)
                          .toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'TV Shows',
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontSize: 18, color: Colors.white)),
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: tvShowsWithPoster.length > 9
                                ? 9
                                : tvShowsWithPoster.length,
                            itemBuilder: (context, index) {
                              final tvShow = tvShowsWithPoster[index];
                              return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TvShowDetailWidget(
                                              tvShowId: tvShow.id!,
                                            ))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.network(
                                      '$imageUrl${tvShow.posterPath}',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 150,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                        width: double.infinity,
                                        height: 150,
                                        color: Colors.black,
                                        child: const Center(
                                          child: Icon(
                                            Icons.image,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          );
  }

  Widget _buildShimmerPlaceholder() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[800]!,
        highlightColor: Colors.grey[600]!,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.7,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.grey[800],
                ),
                width: double.infinity,
                height: 150,
              ),
            );
          },
        ),
      ),
    );
  }
}

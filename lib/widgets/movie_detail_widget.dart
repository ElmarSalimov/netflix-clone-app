import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:netflix_clone/models/movie.dart';
import 'package:netflix_clone/models/movie_detail.dart';
import 'package:netflix_clone/models/movie_recommendation.dart';
import 'package:netflix_clone/provider/movie_provider.dart';
import 'package:netflix_clone/services/api.dart';
import 'package:netflix_clone/util/constants.dart';
import 'package:netflix_clone/screens/player_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailWidget extends StatefulWidget {
  final int movieId;
  final Movie movie;
  const MovieDetailWidget(
      {super.key, required this.movieId, required this.movie});

  @override
  MovieDetailWidgetState createState() => MovieDetailWidgetState();
}

class MovieDetailWidgetState extends State<MovieDetailWidget> {
  ApiService apiServices = ApiService();

  late Future<MovieDetail> movieDetail;
  late Future<MovieRecommendation> movieRecommendation;

  void fetchInitialData() {
    movieDetail = apiServices.getMovieDetail(widget.movieId);
    movieRecommendation = apiServices.getMovieRecommendations(widget.movieId);
  }

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final movieProvider = Provider.of<MovieProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: FutureBuilder<MovieDetail>(
          future: movieDetail,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildShimmerEffect(size);
            } else if (snapshot.hasData) {
              final movie = snapshot.data;

              List<String?> genresText =
                  movie!.genres != null && movie.genres!.isNotEmpty
                      ? movie.genres!.map((genre) => genre.name).toList()
                      : [];

              return Column(
                children: [
                  SizedBox(
                    height: size.height * 0.3,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                "$imageUrl${movie.posterPath}",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SafeArea(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade900,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 6),
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_back_ios,
                                        color: Colors.white, size: 18),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, left: 20, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    movie.title!,
                                    style: GoogleFonts.lato(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    maxLines: 2, // Limits the text to two lines
                                    overflow: TextOverflow
                                        .ellipsis, // Adds ellipsis at the end if text overflows
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      movie.releaseDate.toString(),
                                      style: GoogleFonts.lato(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    if (genresText.isNotEmpty)
                                      Text(
                                        genresText.length > 1
                                            ? "${genresText[0]}, ${genresText[1]}"
                                            : "${genresText[0]}",
                                        style: GoogleFonts.lato(
                                          color: Colors.grey,
                                          fontSize: 13,
                                        ),
                                      ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (!movieProvider.myList
                                        .contains(widget.movie)) {
                                      movieProvider.addToMyList(widget.movie);
                                    } else {
                                      movieProvider
                                          .removeFromMyList(widget.movie);
                                    }
                                  },
                                  child: AnimatedCrossFade(
                                    duration: const Duration(milliseconds: 200),
                                    crossFadeState: movieProvider.myList
                                            .contains(widget.movie)
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                                    firstChild: const Icon(
                                      LucideIcons.check,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    secondChild: const Icon(
                                      LucideIcons.plus,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                Text(
                                  "My List ",
                                  style: GoogleFonts.lato(
                                      textStyle:
                                          const TextStyle(color: Colors.white)),
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    if (!movieProvider.watchedList
                                        .contains(widget.movie)) {
                                      movieProvider
                                          .addToWatchedList(widget.movie);
                                    }
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => PlayerScreen(
                                                movieId: widget.movieId)));
                                  },
                                  child: const Icon(
                                    Icons.play_arrow_sharp,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                Text(
                                  "Play Trailer",
                                  style: GoogleFonts.lato(
                                    textStyle:
                                        const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          movie.overview!,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  FutureBuilder<MovieRecommendation>(
                    future: movieRecommendation,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return buildShimmerEffect(size);
                      } else if (snapshot.hasData) {
                        final recommendation = snapshot.data;

                        final movies = recommendation!.results!
                            .where((movie) => movie.posterPath != null)
                            .toList();

                        return recommendation.results!.isEmpty
                            ? const SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "More like this",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.lato(
                                        fontSize: 18,
                                        color: Colors.grey.shade400,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: 9,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 15,
                                        childAspectRatio: 1.5 / 2,
                                      ),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MovieDetailWidget(
                                                  movieId: movies[index].id!,
                                                  movie:
                                                      movies[index].toMovie(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: ClipRRect(
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "$imageUrl${movies[index].posterPath}",
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                      }
                      return const Text(
                        "Something went wrong",
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget buildShimmerEffect(Size size) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[800]!,
          highlightColor: Colors.grey[700]!,
          child: Container(
            height: size.height * 0.3,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[800]!,
                highlightColor: Colors.grey[700]!,
                child: Container(
                  height: 20,
                  width: size.width * 0.5,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Shimmer.fromColors(
                baseColor: Colors.grey[800]!,
                highlightColor: Colors.grey[700]!,
                child: Container(
                  height: 20,
                  width: size.width * 0.3,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Shimmer.fromColors(
                baseColor: Colors.grey[800]!,
                highlightColor: Colors.grey[700]!,
                child: Container(
                  height: 100,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Shimmer.fromColors(
          baseColor: Colors.grey[800]!,
          highlightColor: Colors.grey[700]!,
          child: Container(
            height: size.height * 0.27,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

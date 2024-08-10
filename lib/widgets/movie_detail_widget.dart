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

  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  fetchInitialData() {
    movieDetail = apiServices.getMovieDetail(widget.movieId);
    movieRecommendation = apiServices.getMovieRecommendations(widget.movieId);
    setState(() {});
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
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              "$imageUrl${movie.posterPath}",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: Colors.white),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title!,
                                    style: GoogleFonts.lato(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
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
                                          fontSize: 17,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      if (genresText.isNotEmpty)
                                        Text(
                                          genresText.length > 1
                                              ? "${genresText[0]}, ${genresText[1]}"
                                              : "${genresText[0]}",
                                          style: GoogleFonts.lato(
                                            color: Colors.grey,
                                            fontSize: 17,
                                          ),
                                        ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
                                      size: 40,
                                    ),
                                    secondChild: const Icon(
                                      LucideIcons.plus,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                Text(
                                  "My List ",
                                  style: GoogleFonts.lato(
                                      textStyle:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const SizedBox(height: 30),
                        Text(
                          movie.overview!,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 16,
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
                                        color: Colors.white,
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
              return const Center(
                child: Text(
                  "Something went wrong",
                  style: TextStyle(color: Colors.white),
                ),
              );
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
          highlightColor: Colors.grey[500]!,
          child: Container(
            height: size.height * 0.4,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25, left: 20, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[800]!,
                highlightColor: Colors.grey[500]!,
                child: Container(
                  width: size.width * 0.6,
                  height: 24,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Shimmer.fromColors(
                baseColor: Colors.grey[800]!,
                highlightColor: Colors.grey[500]!,
                child: Container(
                  width: size.width * 0.4,
                  height: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              Shimmer.fromColors(
                baseColor: Colors.grey[800]!,
                highlightColor: Colors.grey[500]!,
                child: Container(
                  width: size.width * 0.8,
                  height: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Shimmer.fromColors(
                baseColor: Colors.grey[800]!,
                highlightColor: Colors.grey[500]!,
                child: Container(
                  width: size.width * 0.8,
                  height: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Shimmer.fromColors(
                baseColor: Colors.grey[800]!,
                highlightColor: Colors.grey[500]!,
                child: Container(
                  width: size.width * 0.8,
                  height: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Shimmer.fromColors(
          baseColor: Colors.grey[800]!,
          highlightColor: Colors.grey[500]!,
          child: Container(
            height: size.height * 0.4,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

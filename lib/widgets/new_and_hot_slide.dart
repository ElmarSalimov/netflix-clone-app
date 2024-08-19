import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:netflix_clone/provider/movie_provider.dart';
import 'package:netflix_clone/util/constants.dart';
import 'package:netflix_clone/widgets/movie_detail_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class NewAndHotSlide extends StatefulWidget {
  const NewAndHotSlide({super.key});

  @override
  State<NewAndHotSlide> createState() => _NewAndHotSlideState();
}

class _NewAndHotSlideState extends State<NewAndHotSlide> {
  List<String> convertGenreIdsToNames(List<int> genreIds) {
    return genreIds.map((id) => genreMap[id] ?? "Unknown").toList();
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context, listen: true);
    return ListView.builder(
      controller: controller,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 9,
      itemBuilder: (BuildContext context, int index) {
        final movie = movieProvider.upcomingMovies[index];

        final String releaseDate =
            movieProvider.upcomingMovies[index].releaseDate!;
        DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(releaseDate);
        List<String> formattedDate =
            DateFormat("d MMMM").format(parsedDate).split(" ");
        List<String?> genresText =
            movie.genreIds != null && movie.genreIds!.isNotEmpty
                ? convertGenreIdsToNames(movie.genreIds!)
                : [];

        return Container(
          height: 500,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            children: [
              SizedBox(
                width: 45,
                child: Column(
                  children: [
                    Text(
                      formattedDate[1].substring(0, 3),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    Text(
                      formattedDate[0],
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          letterSpacing: 2),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 45,
                      height: 60,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (!movieProvider.myList.contains(movie)) {
                                movieProvider.addToMyList(movie);
                              } else {
                                movieProvider.removeFromMyList(movie);
                              }
                            },
                            child: AnimatedCrossFade(
                              duration: const Duration(milliseconds: 200),
                              crossFadeState:
                                  movieProvider.myList.contains(movie)
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
                          Expanded(
                            child: Text(
                              "My list",
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      fontSize: 13, color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align to left
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MovieDetailWidget(
                                    movieId: movie.id!,
                                    movie: movie,
                                  )));
                        },
                        child: SafeArea(
                          child: SizedBox(
                            height: 150,
                            width: 260,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: '$imageUrl${movie.posterPath}',
                                fit: BoxFit.fitWidth,
                                placeholder: (context, url) => Shimmer.fromColors(
                                  baseColor: Colors.grey[850]!,
                                  highlightColor: Colors.grey[800]!,
                                  child: Container(
                                    color: Colors.black,
                                  ),
                                ),
                                errorWidget: (context, url, error) => const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align to left
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: SizedBox(
                            width: 260,
                            child: Text(
                              movie.title!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        if (genresText.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: SizedBox(
                              width: 260,
                              child: Row(
                                children: [
                                  Text(
                                    genresText.length > 1
                                        ? "${genresText[0]}, ${genresText[1]}"
                                        : "${genresText[0]}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: SizedBox(
                            width: 260, 
                            child: Text(
                              movie.overview!,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

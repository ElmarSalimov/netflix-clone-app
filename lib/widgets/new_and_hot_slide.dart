import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/provider/movie_provider.dart';
import 'package:netflix_clone/util/constants.dart';
import 'package:provider/provider.dart';

class NewAndHotSlide extends StatefulWidget {
  const NewAndHotSlide({
    super.key,
  });

  @override
  State<NewAndHotSlide> createState() => _NewAndHotSlideState();
}

class _NewAndHotSlideState extends State<NewAndHotSlide> {

  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    return ListView.builder(
      controller: controller,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: movieProvider.upcomingMovies.length,
      itemBuilder: (BuildContext context, int index) {
        final result = movieProvider.upcomingMovies[index];

        final String releaseDate =
            movieProvider.upcomingMovies[index].releaseDate!;
        DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(releaseDate);
        List<String> formattedDate =
            DateFormat("d MMMM").format(parsedDate).split(" ");

        return Container(
          height: 500,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            children: [
              SizedBox(
                width: 40,
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
                          letterSpacing: 3),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align to left
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 250,
                        width: 350,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            '$imageUrl${result.posterPath}',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align to left
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "Coming ${formattedDate[1]} ${formattedDate[0]}",
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: SizedBox(
                            width: 350,
                            child: Row(
                              children: [
                                Text(
                                  result.title!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: SizedBox(
                            width: 350, // Set a specific width
                            child: Text(
                              result.overview!,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                color: Colors.grey,
                                fontSize: 16,
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

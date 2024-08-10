import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/util/constants.dart';
import 'package:netflix_clone/widgets/movie_detail_widget.dart';
import 'package:netflix_clone/widgets/tv_detail_widget.dart';
import 'package:shimmer/shimmer.dart';

class HomeSlide extends StatelessWidget {
  final List list;
  final String headlineText;
  final String type;
  final ScrollController controller;

  const HomeSlide({
    super.key,
    required this.list,
    required this.headlineText,
    required this.type,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(headlineText,
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            fontSize: 18, color: Colors.white))),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                final result = list[index];
                return Container(
                  width: 130, // Set a fixed width to maintain consistent layout
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      if (type == "Movie") {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MovieDetailWidget(
                                  movieId: result.id,
                                  movie: result,
                                )));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                TvShowDetailWidget(tvShowId: result.id)));
                      }
                    },
                    child: CachedNetworkImage(
                      imageUrl: '$imageUrl${result.posterPath}',
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[700]!,
                        highlightColor: Colors.grey[500]!,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey[800],
                          ),
                          width: 120,
                          height: 200,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

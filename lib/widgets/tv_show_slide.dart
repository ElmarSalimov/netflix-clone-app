import 'package:flutter/material.dart';
import 'package:netflix_clone/models/tv_show.dart';
import 'package:netflix_clone/util/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class TvShowSlide extends StatelessWidget {
  final List<TvShow> tvshows;
  final String headlineText;
  final ScrollController controller;

  const TvShowSlide({
    super.key,
    required this.tvshows,
    required this.headlineText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
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
                            fontSize: 22, color: Colors.white))),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemCount: tvshows.length,
              itemBuilder: (BuildContext context, int index) {
                final TvShow result = tvshows[index];
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Image.network(
                    '$imageUrl${result.posterPath}',
                    fit: BoxFit.cover,
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
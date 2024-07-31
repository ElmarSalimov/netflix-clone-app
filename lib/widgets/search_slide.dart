import 'package:flutter/material.dart';
import 'package:netflix_clone/util/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchSlide extends StatelessWidget {
  final List list;

  const SearchSlide({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "Top Searches",
            style: GoogleFonts.lato(
                textStyle: const TextStyle(fontSize: 16, color: Colors.white)),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              // shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                final result = list[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 120,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Image.network(
                          '$imageUrl${result.posterPath}',
                          fit: BoxFit.fitHeight,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(result.originalTitle,
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    fontSize: 16, color: Colors.white)))
                      ],
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

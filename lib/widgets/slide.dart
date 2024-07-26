import 'package:flutter/material.dart';
import 'package:netflix_clone/util/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class Slide extends StatelessWidget {
  final List list;
  final String headlineText;
  final String type;
  final ScrollController controller;

  const Slide({
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

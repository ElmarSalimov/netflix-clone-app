import 'package:flutter/material.dart';
import 'package:netflix_clone/util/constants.dart';
import 'package:netflix_clone/models/upcoming_movie.dart';

class MovieSlide extends StatelessWidget {
  late Future<UpcomingMovie> future;
  final String headlineText;

  MovieSlide(
      {super.key, required this.future, required this.headlineText});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UpcomingMovie>(
      future: future,
      builder: (context, snapshot) {
        var data = snapshot.data!.results;

        return Column(
          children: [
            Text(
              headlineText,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.network("$imageUrl${data[index].posterPath}"),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

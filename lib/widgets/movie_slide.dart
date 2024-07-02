import 'package:flutter/material.dart';
import 'package:netflix_clone/models/upcoming_movie.dart';
import 'package:netflix_clone/util/constants.dart';

class UpcomingMovieCard extends StatelessWidget {
  final Future<UpcomingMovie> future;

  final String headlineText;
  const UpcomingMovieCard({
    super.key,
    required this.future,
    required this.headlineText,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UpcomingMovie>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data?.results;

            return Column(
                children: [
                  Text(
                    headlineText,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      // padding: const EdgeInsets.all(3),
                      scrollDirection: Axis.horizontal,
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Image.network(
                                  '$imageUrl${data[index].posterPath}',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            );
                      },
                    ),
                  )
                ]);
          } 

          // This is the case 
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          
          else {
            return const Center(child: Text("No Data"));
          }
        });
  }
}
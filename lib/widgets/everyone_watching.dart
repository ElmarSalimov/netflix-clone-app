import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/provider/movie_provider.dart';
import 'package:netflix_clone/util/constants.dart';
import 'package:netflix_clone/widgets/movie_detail_widget.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class EveryoneWatchingSlide extends StatefulWidget {
  const EveryoneWatchingSlide({
    super.key,
  });

  @override
  State<EveryoneWatchingSlide> createState() => _EveryoneWatchingSlideState();
}

class _EveryoneWatchingSlideState extends State<EveryoneWatchingSlide> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    final width = MediaQuery.sizeOf(context).width;
    return ListView.builder(
      controller: controller,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 9,
      itemBuilder: (BuildContext context, int index) {
        final movie = movieProvider.topSearches[index];
        return Container(
          height: 500,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MovieDetailWidget(
                              movieId: movie.id!,
                              movie: movie,
                            ),
                          ));
                        },
                        child: SizedBox(
                          height: 170,
                          width: width * 0.8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: '$imageUrl${movie.posterPath}',
                              fit: BoxFit.fitWidth,
                              placeholder: (context, url) =>
                                  _buildShimmerPlaceholder(
                                      width: 390, height: 170),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.black,
                                child: const Center(
                                  child: Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: SizedBox(
                            width: width * 0.8,
                            child: Text(
                              movie.title!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: SizedBox(
                            width: width * 0.8,
                            child: Text(
                              movie.overview!,
                              maxLines: 4,
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

  Widget _buildShimmerPlaceholder(
      {double width = double.infinity, double height = 150}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: Container(
        width: width,
        height: height,
        color: Colors.grey[800],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/models/tv_show_detail.dart';
import 'package:netflix_clone/models/tv_show_recommendation.dart';
import 'package:netflix_clone/services/api.dart';
import 'package:netflix_clone/util/constants.dart';

class TvShowDetailWidget extends StatefulWidget {
  final int tvShowId;
  const TvShowDetailWidget({super.key, required this.tvShowId});

  @override
  TvShowDetailWidgetState createState() => TvShowDetailWidgetState();
}

class TvShowDetailWidgetState extends State<TvShowDetailWidget> {
  ApiService apiServices = ApiService();

  late Future<TvShowDetail> tvShowDetail;
  late Future<TvShowRecommendation> tvShowRecommendation;

  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  fetchInitialData() {
    tvShowDetail = apiServices.getTvShowDetail(widget.tvShowId);
    tvShowRecommendation = apiServices.getTvShowRecommendations(widget.tvShowId);
    setState(() {});  
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: FutureBuilder<TvShowDetail>(
          future: tvShowDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final tvShow = snapshot.data;
              String genresText =
                  tvShow!.genres!.map((genre) => genre.name).join(', ');

              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              "$imageUrl${tvShow.posterPath}",
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
                        const EdgeInsets.only(top: 25, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tvShow.name!,
                          style: GoogleFonts.lato(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              tvShow.firstAirDate.toString(),
                              style: GoogleFonts.lato(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              genresText,
                              style: GoogleFonts.lato(
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          tvShow.overview!,
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
                  const SizedBox(
                    height: 30,
                  ),
                  FutureBuilder<TvShowRecommendation>(
                    future: tvShowRecommendation,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final recommendation = snapshot.data;

                        return recommendation!.results!.isEmpty
                            ? const SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "More like this",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  GridView.builder(
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
                                                  TvShowDetailWidget(
                                                tvShowId: recommendation
                                                    .results![index].id!,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Image.network(
                                          "$imageUrl${recommendation.results![index].posterPath}",
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                      }
                      return const Text(
                        "Something Went wrong",
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ],
              );
            }
            return Center(
              child: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          },
        ),
      ),
    );
  }
}

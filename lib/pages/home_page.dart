import 'package:flutter/material.dart';
import 'package:netflix_clone/models/movie.dart';
import 'package:netflix_clone/models/tv_show.dart';
import 'package:netflix_clone/services/api.dart';
import 'package:netflix_clone/widgets/app_bar.dart';
import 'package:netflix_clone/widgets/movie_slide.dart';
import 'package:netflix_clone/widgets/tv_show_slide.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiServices = ApiService();

  // Lists
  List<Movie> upcomingMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> nowPlayingMovies = [];
  List<Movie> actionMovies = [];
  List<Movie> horrorMovies = [];

  List<TvShow> popularTvShows = [];

  // Controllers
  ScrollController upcomingController = ScrollController();
  ScrollController popularController = ScrollController();
  ScrollController topRatedController = ScrollController();
  ScrollController nowPlayingController = ScrollController();
  ScrollController actionController = ScrollController();
  ScrollController horrorController = ScrollController();

  ScrollController popularTvController = ScrollController();

  // Booleans
  bool loadUpcoming = false;
  bool loadPopular = false;
  bool loadTopRated = false;
  bool loadNowPlaying = false;
  bool loadAction = false;
  bool loadHorror = false;

  bool loadPopularTv = false;

  @override
  void initState() {
    super.initState();

    fetchUpcomingMovies();
    fetchPopularMovies();
    fetchTopRatedMovies();
    fetchNowPlayingMovies();
    fetchActionMovies();
    fetchHorrorMovies();

    fetchPopularTvShows();

    upcomingController.addListener(_upcomingScrollListener);
    popularController.addListener(_popularScrollListener);
    topRatedController.addListener(_topRatedScrollListener);
    nowPlayingController.addListener(_nowPlayingScrollListener);
    actionController.addListener(_actionScrollListener);
    horrorController.addListener(_horrorScrollListener);

    popularTvController.addListener(_popularTvScrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 100),
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.black,
          extendBodyBehindAppBar: true,

          // App Bar
          appBar: MyAppBar(),

          // Body
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _movies(),
              _tvshows(),
            ],
          )),
    );
  }

  void _upcomingScrollListener() {
    if (upcomingController.position.pixels ==
        upcomingController.position.maxScrollExtent) {
      fetchUpcomingMovies();
    }
  }

  void _popularScrollListener() {
    if (popularController.position.pixels ==
        popularController.position.maxScrollExtent) {
      fetchPopularMovies();
    }
  }

  void _topRatedScrollListener() {
    if (topRatedController.position.pixels ==
        topRatedController.position.maxScrollExtent) {
      fetchTopRatedMovies();
    }
  }

  void _nowPlayingScrollListener() {
    if (nowPlayingController.position.pixels ==
        nowPlayingController.position.maxScrollExtent) {
      fetchNowPlayingMovies();
    }
  }

  void _actionScrollListener() {
    if (actionController.position.pixels ==
        actionController.position.maxScrollExtent) {
      fetchActionMovies();
    }
  }

  void _horrorScrollListener() {
    if (horrorController.position.pixels ==
        horrorController.position.maxScrollExtent) {
      fetchHorrorMovies();
    }
  }

  void _popularTvScrollListener() {
    if (popularTvController.position.pixels ==
        popularTvController.position.maxScrollExtent) {
      fetchPopularTvShows();
    }
  }

  Future<void> fetchUpcomingMovies() async {
    if (loadUpcoming) return;
    setState(() {
      loadUpcoming = true;
    });

    List<Movie> newMovies = await apiServices.getUpcomingMovies();
    setState(() {
      upcomingMovies.addAll(newMovies);
      loadUpcoming = false;
    });
  }

  Future<void> fetchPopularMovies() async {
    if (loadPopular) return;
    setState(() {
      loadPopular = true;
    });

    List<Movie> newMovies = await apiServices.getPopularMovies();
    setState(() {
      popularMovies.addAll(newMovies);
      loadPopular = false;
    });
  }

  Future<void> fetchTopRatedMovies() async {
    if (loadTopRated) return;
    setState(() {
      loadTopRated = true;
    });

    List<Movie> newMovies = await apiServices.getTopRatedMovies();
    setState(() {
      topRatedMovies.addAll(newMovies);
      loadTopRated = false;
    });
  }

  Future<void> fetchNowPlayingMovies() async {
    if (loadNowPlaying) return;
    setState(() {
      loadNowPlaying = true;
    });

    List<Movie> newMovies = await apiServices.getNowPlayingMovies();
    setState(() {
      nowPlayingMovies.addAll(newMovies);
      loadNowPlaying = false;
    });
  }

  Future<void> fetchActionMovies() async {
    if (loadAction) return;
    setState(() {
      loadAction = true;
    });

    List<Movie> newMovies = await apiServices.getActionMovies();
    setState(() {
      actionMovies.addAll(newMovies);
      loadAction = false;
    });
  }

  Future<void> fetchHorrorMovies() async {
    if (loadHorror) return;
    setState(() {
      loadHorror = true;
    });

    List<Movie> newMovies = await apiServices.getHorrorMovies();
    setState(() {
      horrorMovies.addAll(newMovies);
      loadHorror = false;
    });
  }

  Future<void> fetchPopularTvShows() async {
    if (loadPopularTv) return;
    setState(() {
      loadPopularTv = true;
    });

    List<TvShow> newMovies = await apiServices.getPopularTvShows();
    setState(() {
      popularTvShows.addAll(newMovies);
      loadPopularTv = false;
    });
  }

  Widget _movies() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          MovieSlide(
              movies: upcomingMovies,
              headlineText: "Upcoming",
              controller: upcomingController),
          const SizedBox(height: 10),
          MovieSlide(
              movies: popularMovies,
              headlineText: "Popular",
              controller: popularController),
          const SizedBox(height: 10),
          MovieSlide(
              movies: topRatedMovies,
              headlineText: "Top Rated",
              controller: topRatedController),
          const SizedBox(height: 10),
          MovieSlide(
              movies: nowPlayingMovies,
              headlineText: "Now Playing",
              controller: nowPlayingController),
          const SizedBox(height: 10),
          MovieSlide(
              movies: actionMovies,
              headlineText: "Action",
              controller: actionController),
          const SizedBox(height: 10),
          MovieSlide(
              movies: horrorMovies,
              headlineText: "Horror",
              controller: horrorController)
        ],
      ),
    );
  }

  Widget _tvshows() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          TvShowSlide(
              tvshows: popularTvShows,
              headlineText: "Popular",
              controller: popularTvController)
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflix_clone/models/movie.dart';
import 'package:netflix_clone/models/tv_show.dart';
import 'package:netflix_clone/services/api.dart';

class MovieProvider extends ChangeNotifier {
  ApiService apiServices = ApiService();

  // Lists
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> actionMovies = [];
  List<Movie> topSearches = [];
  List<Movie> upcomingMovies = [];

  List<TvShow> airingTvShows = [];
  List<TvShow> dramaTvShows = [];
  List<TvShow> animationTvShows = [];

  // Controllers
  ScrollController popularController = ScrollController();
  ScrollController topRatedController = ScrollController();
  ScrollController actionController = ScrollController();

  ScrollController airingTvController = ScrollController();
  ScrollController dramaTvController = ScrollController();
  ScrollController animationTvController = ScrollController();

  // Booleans
  bool loadPopular = false;
  bool loadTopRated = false;
  bool loadAction = false;

  bool loadAiringTv = false;
  bool loadDramaTv = false;
  bool loadAnimationTv = false;

  MovieProvider() {
    popularController.addListener(_popularListener);
    topRatedController.addListener(_topRatedListener);
    actionController.addListener(_actionListener);

    airingTvController.addListener(_airingTvListener);
    dramaTvController.addListener(_dramaTvListener);
    animationTvController.addListener(_animationTvListener);
  }

  Future<void> fetchTopSearches() async {
    List<Movie> newMovies = await apiServices.getTopSearches();
    topSearches = newMovies;
    notifyListeners();
  }

  Future<void> fetchUpcomingMovies() async {
    List<Movie> newMovies = await apiServices.getUpcomingMovies();
    upcomingMovies = newMovies;
    notifyListeners();
  }

  Future<void> fetchPopularMovies() async {
    if (loadPopular) return;
    loadPopular = true;

    List<Movie> newMovies = await apiServices.getPopularMovies();
    popularMovies.addAll(newMovies);
    loadPopular = false;
    notifyListeners();
  }

  Future<void> fetchTopRatedMovies() async {
    if (loadTopRated) return;
    loadTopRated = true;

    List<Movie> newMovies = await apiServices.getTopRatedMovies();
    topRatedMovies.addAll(newMovies);
    loadTopRated = false;
    notifyListeners();
  }

  Future<void> fetchActionMovies() async {
    if (loadAction) return;
    loadAction = true;

    List<Movie> newMovies = await apiServices.getActionMovies();
    actionMovies.addAll(newMovies);
    loadAction = false;
    notifyListeners();
  }

  Future<void> fetchAiringTvShows() async {
    if (loadAiringTv) return;
    loadAiringTv = true;

    List<TvShow> newShows = await apiServices.getAiringTvShows();
    airingTvShows.addAll(newShows);
    loadAiringTv = false;
    notifyListeners();
  }

  Future<void> fetchDramaTvShows() async {
    if (loadDramaTv) return;
    loadDramaTv = true;

    List<TvShow> newShows = await apiServices.getDramaTvShows();
    dramaTvShows.addAll(newShows);
    loadDramaTv = false;
    notifyListeners();
  }

  Future<void> fetchAnimationTvShows() async {
    if (loadAnimationTv) return;
    loadAnimationTv = true;

    List<TvShow> newShows = await apiServices.getAnimationTvShows();
    animationTvShows.addAll(newShows);
    loadAnimationTv = false;
    notifyListeners();
  }

  Future<void> fetchAll() async {
    fetchPopularMovies();
    fetchTopRatedMovies();
    fetchActionMovies();
    fetchTopSearches();
    fetchUpcomingMovies();

    fetchAiringTvShows();
    fetchDramaTvShows();
    fetchAnimationTvShows();
  }

  void _popularListener() {
    if (popularController.position.pixels ==
        popularController.position.maxScrollExtent) {
      fetchPopularMovies();
    }
  }

  void _topRatedListener() {
    if (topRatedController.position.pixels ==
        topRatedController.position.maxScrollExtent) {
      fetchTopRatedMovies();
    }
  }

  void _actionListener() {
    if (actionController.position.pixels ==
        actionController.position.maxScrollExtent) {
      fetchActionMovies();
    }
  }

  void _airingTvListener() {
    if (airingTvController.position.pixels ==
        airingTvController.position.maxScrollExtent) {
      fetchAiringTvShows();
    }
  }

  void _dramaTvListener() {
    if (dramaTvController.position.pixels ==
        dramaTvController.position.maxScrollExtent) {
      fetchDramaTvShows();
    }
  }

  void _animationTvListener() {
    if (animationTvController.position.pixels ==
        animationTvController.position.maxScrollExtent) {
      fetchAnimationTvShows();
    }
  }
}

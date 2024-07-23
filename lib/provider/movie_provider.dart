import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflix_clone/models/movie.dart';
import 'package:netflix_clone/models/tv_show.dart';
import 'package:netflix_clone/services/api.dart';

class MovieProvider extends ChangeNotifier {
  ApiService apiServices = ApiService();

  // Lists
  List<Movie> upcomingMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> nowPlayingMovies = [];
  List<Movie> actionMovies = [];
  List<Movie> horrorMovies = [];

  List<TvShow> popularTvShows = [];
  List<TvShow> topRatedTvShows = [];
  List<TvShow> airingTvShows = [];
  List<TvShow> dramaTvShows = [];
  List<TvShow> animationTvShows = [];
  
  // Controllers
  ScrollController upcomingController = ScrollController();
  ScrollController popularController = ScrollController();
  ScrollController topRatedController = ScrollController();
  ScrollController nowPlayingController = ScrollController();
  ScrollController actionController = ScrollController();
  ScrollController horrorController = ScrollController();
  
  ScrollController popularTvController = ScrollController();
  ScrollController topRatedTvController = ScrollController();
  ScrollController airingTvController = ScrollController();
  ScrollController dramaTvController = ScrollController();
  ScrollController animationTvController = ScrollController();

  // Booleans
  bool loadUpcoming = false;
  bool loadPopular = false;
  bool loadTopRated = false;
  bool loadNowPlaying = false;
  bool loadAction = false;
  bool loadHorror = false;
  
  bool loadPopularTv = false;
  bool loadTopRatedTv = false;
  bool loadAiringTv = false;
  bool loadDramaTv = false;
  bool loadAnimationTv = false;

  MovieProvider() {
    upcomingController.addListener(_upcomingListener);
    popularController.addListener(_popularListener);
    topRatedController.addListener(_topRatedListener);
    nowPlayingController.addListener(_nowPlayingListener);
    actionController.addListener(_actionListener);
    horrorController.addListener(_horrorListener);
    
    popularTvController.addListener(_popularTvListener);
    topRatedTvController.addListener(_topRatedTvListener);
    airingTvController.addListener(_airingTvListener);
    dramaTvController.addListener(_dramaTvListener);
    animationTvController.addListener(_animationTvListener);
  }

  Future<void> fetchUpcomingMovies() async {
    if (loadUpcoming) return;
    loadUpcoming = true;

    List<Movie> newMovies = await apiServices.getUpcomingMovies();
    upcomingMovies.addAll(newMovies);
    loadUpcoming = false;
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

  Future<void> fetchNowPlayingMovies() async {
    if (loadNowPlaying) return;
    loadNowPlaying = true;

    List<Movie> newMovies = await apiServices.getNowPlayingMovies();
    nowPlayingMovies.addAll(newMovies);
    loadNowPlaying = false;
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

  Future<void> fetchHorrorMovies() async {
    if (loadHorror) return;
    loadHorror = true;

    List<Movie> newMovies = await apiServices.getHorrorMovies();
    horrorMovies.addAll(newMovies);
    loadHorror = false;
    notifyListeners();
  }

  Future<void> fetchPopularTvShows() async {
    if (loadPopularTv) return;
    loadPopularTv = true;

    List<TvShow> newShows = await apiServices.getPopularTvShows();
    popularTvShows.addAll(newShows);
    loadPopularTv = false;
    notifyListeners();
  }

  Future<void> fetchTopRatedTvShows() async {
    if (loadTopRatedTv) return;
    loadTopRatedTv = true;

    List<TvShow> newShows = await apiServices.getTopRatedTvShows();
    topRatedTvShows.addAll(newShows);
    loadTopRatedTv = false;
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
    fetchUpcomingMovies();
    fetchPopularMovies();
    fetchTopRatedMovies();
    fetchNowPlayingMovies();
    fetchActionMovies();
    fetchHorrorMovies();
    
    fetchPopularTvShows();
    fetchTopRatedTvShows();
    fetchAiringTvShows();
    fetchDramaTvShows();
    fetchAnimationTvShows();
  }

  void _upcomingListener() {
    if (upcomingController.position.pixels ==
        upcomingController.position.maxScrollExtent) {
      fetchUpcomingMovies();
    }
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

  void _nowPlayingListener() {
    if (nowPlayingController.position.pixels ==
        nowPlayingController.position.maxScrollExtent) {
      fetchNowPlayingMovies();
    }
  }

  void _actionListener() {
    if (actionController.position.pixels ==
        actionController.position.maxScrollExtent) {
      fetchActionMovies();
    }
  }

  void _horrorListener() {
    if (horrorController.position.pixels ==
        horrorController.position.maxScrollExtent) {
      fetchHorrorMovies();
    }
  }

  void _popularTvListener() {
    if (popularTvController.position.pixels ==
        popularTvController.position.maxScrollExtent) {
      fetchPopularTvShows();
    }
  }

  void _topRatedTvListener() {
    if (popularTvController.position.pixels ==
        popularTvController.position.maxScrollExtent) {
      fetchTopRatedTvShows();
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

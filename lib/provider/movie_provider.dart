import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflix_clone/models/movie.dart';
import 'package:netflix_clone/models/tv_show.dart';
import 'package:netflix_clone/services/api.dart';

class MovieProvider extends ChangeNotifier {
  ApiService apiServices = ApiService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Lists
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> actionMovies = [];
  List<Movie> topSearches = [];
  List<Movie> upcomingMovies = [];

  List<TvShow> airingTvShows = [];
  List<TvShow> dramaTvShows = [];
  List<TvShow> animationTvShows = [];

  List<Movie> myList = [];
  List<Movie> watchedList = [];

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

  void addToMyList(Movie movie) {
    if (!myList.contains(movie)) {
      myList.add(movie);
      notifyListeners();
    }
    uploadUserData();
  }

  void removeFromMyList(Movie movie) {
    myList.remove(movie);
    notifyListeners();
    uploadUserData();
  }

  void addToWatchedList(Movie movie) {
    if (!watchedList.contains(movie)) {
      watchedList.add(movie);
      notifyListeners();
    }
    uploadUserData();
  }

  void removeFromWatchedList(Movie movie) {
    watchedList.remove(movie);
    notifyListeners();
    uploadUserData();
  }

  // Method to upload user's movie list to Firestore
  Future<void> uploadUserData() async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    final email = user.email;

    if (email == null) {
      log('No user logged in');
      return;
    }

    try {
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(uid);

      // Create or update user document
      await userDoc.set({
        'email': email,
        'movies': myList.map((movie) => movie.toJson()).toList(),
        'watched': watchedList.map((movie) => movie.toJson()).toList(),
      }, SetOptions(merge: true));

      log('User data uploaded successfully');
    } catch (e) {
      log('Failed to upload user data: $e');
    }
  }

  // Method to retrieve user's movie list from Firestore
  Future<void> fetchUserData() async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    final email = user.email;
    if (email == null) {
      log('No user logged in');
      return;
    }

    try {
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(uid);
      DocumentSnapshot userSnapshot = await userDoc.get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        List<dynamic> moviesData = userData['movies'] as List<dynamic>;
        List<dynamic> watchedMovies = userData['watched'] as List<dynamic>;

        myList = moviesData
            .map((movieData) =>
                Movie.fromJson(movieData as Map<String, dynamic>))
            .toList();
        watchedList = watchedMovies
            .map((movieData) =>
                Movie.fromJson(movieData as Map<String, dynamic>))
            .toList();

        log('User data retrieved successfully for email: $email');
      } else {
        log('No user data found for email: $email');
      }

      notifyListeners();
    } catch (e) {
      log('Failed to fetch user data: $e');
    }
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
    await fetchPopularMovies();
    await fetchTopRatedMovies();
    await fetchActionMovies();
    await fetchTopSearches();
    await fetchUpcomingMovies();

    await fetchAiringTvShows();
    await fetchDramaTvShows();
    await fetchAnimationTvShows();
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

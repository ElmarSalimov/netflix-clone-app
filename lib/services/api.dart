import 'dart:convert';
import 'package:netflix_clone/models/tv_show.dart';
import 'package:netflix_clone/util/constants.dart';
import 'package:netflix_clone/models/movie.dart';
import 'package:http/http.dart' as http;

late String endpoint;

class ApiService {
  int upcomingPage = 1;
  int popularPage = 1;
  int topRatedPage = 1;
  int nowPlayingPage = 1;
  int actionPage = 1;
  int horrorPage = 1;

  int popularTvPage = 1;

  Future<List<Movie>> getUpcomingMovies() async {
    endpoint = "movie/upcoming";
    final url = "$baseUrl$endpoint$key&page=$upcomingPage";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'] as List;
      final List<Movie> movieList = data.map((e) => Movie.fromJson(e)).toList();
      upcomingPage++;
      return movieList;
    }
    throw Exception("Fail");
  }

  Future<List<Movie>> getPopularMovies() async {
    endpoint = "movie/popular";
    final url = "$baseUrl$endpoint$key&page=$popularPage";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'] as List;
      final List<Movie> movieList = data.map((e) => Movie.fromJson(e)).toList();
      popularPage++;
      return movieList;
    }
    throw Exception("Fail");
  }

  Future<List<Movie>> getTopRatedMovies() async {
    endpoint = "movie/top_rated";
    final url = "$baseUrl$endpoint$key&page=$topRatedPage";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'] as List;
      final List<Movie> movieList = data.map((e) => Movie.fromJson(e)).toList();
      topRatedPage++;
      return movieList;
    }
    throw Exception("Fail");
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    endpoint = "movie/now_playing";
    final url = "$baseUrl$endpoint$key&page=$nowPlayingPage";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'] as List;
      final List<Movie> movieList = data.map((e) => Movie.fromJson(e)).toList();
      nowPlayingPage++;
      return movieList;
    }
    throw Exception("Fail");
  }

  Future<List<Movie>> getActionMovies() async {
    endpoint = "movie/popular";
    final List<Movie> newMovieList = [];

    while (newMovieList.length < 15) {
      final url = "$baseUrl$endpoint$key&page=$actionPage";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['results'] as List;
        final List<Movie> movieList =
            data.map((e) => Movie.fromJson(e)).toList();

        for (var i = 0; i < movieList.length; i++) {
          if (movieList[i].genreIds!.contains(28)) {
            newMovieList.add(movieList[i]);
          }
        }
      }
      if (response.statusCode == 401) {
        throw Exception("Fail");
      }
      actionPage++;
    }
    return newMovieList;
  }

  Future<List<Movie>> getHorrorMovies() async {
    endpoint = "movie/popular";
    final List<Movie> newMovieList = [];

    while (newMovieList.length < 15) {
      final url = "$baseUrl$endpoint$key&page=$horrorPage";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['results'] as List;
        final List<Movie> movieList =
            data.map((e) => Movie.fromJson(e)).toList();

        for (var i = 0; i < movieList.length; i++) {
          if (movieList[i].genreIds!.contains(27)) {
            newMovieList.add(movieList[i]);
          }
        }
      }
      if (response.statusCode == 401) {
        throw Exception("Fail");
      }
      horrorPage++;
    }
    return newMovieList;
  }

  Future<List<TvShow>> getPopularTvShows() async {
    endpoint = "tv/popular";
    final url = "$baseUrl$endpoint$key&page=$popularTvPage";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'] as List;
      final List<TvShow> tvShowList = data.map((e) => TvShow.fromJson(e)).toList();
      popularTvPage++;
      return tvShowList;
    }
    throw Exception("Fail");
  }
}

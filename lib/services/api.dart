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
  int topRatedTvPage = 1;
  int airingTvPage = 1;
  int dramaTvPage = 1;
  int animationTvPage = 1;

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
    endpoint = "discover/movie";
    final url = "$baseUrl$endpoint$key&page=$actionPage&with_genres=${28}";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'] as List;
      final List<Movie> movieList = data.map((e) => Movie.fromJson(e)).toList();
      actionPage++;
      return movieList;
    }
    throw Exception("Fail");
  }

  Future<List<Movie>> getHorrorMovies() async {
    endpoint = "discover/movie";
    final url = "$baseUrl$endpoint$key&page=$horrorPage&with_genres=${27}";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'] as List;
      final List<Movie> movieList = data.map((e) => Movie.fromJson(e)).toList();
      horrorPage++;
      return movieList;
    }
    throw Exception("Fail");
  }

  Future<List<TvShow>> getPopularTvShows() async {
    endpoint = "tv/popular";
    final url = "$baseUrl$endpoint$key&page=$popularTvPage";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'] as List;
      final List<TvShow> tvShowList =
          data.map((e) => TvShow.fromJson(e)).toList();
      popularTvPage++;
      return tvShowList;
    }
    throw Exception("Fail");
  }

  Future<List<TvShow>> getTopRatedTvShows() async {
    endpoint = "tv/top_rated";
    final url = "$baseUrl$endpoint$key&page=$topRatedTvPage";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'] as List;
      final List<TvShow> tvShowList =
          data.map((e) => TvShow.fromJson(e)).toList();
      topRatedTvPage++;
      return tvShowList;
    }
    throw Exception("Fail");
  }

  Future<List<TvShow>> getAiringTvShows() async {
    endpoint = "tv/on_the_air";
    final url = "$baseUrl$endpoint$key&page=$airingTvPage";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'] as List;
      final List<TvShow> tvShowList =
          data.map((e) => TvShow.fromJson(e)).toList();
      airingTvPage++;
      return tvShowList;
    }
    throw Exception("Fail");
  }

  Future<List<TvShow>> getDramaTvShows() async {
    endpoint = "discover/tv";
    final url = "$baseUrl$endpoint$key&page=$dramaTvPage&with_genres=${18}";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'] as List;
      final List<TvShow> tvShowList = data.map((e) => TvShow.fromJson(e)).toList();
      dramaTvPage++;
      return tvShowList;
    }
    throw Exception("Fail");
  }

  Future<List<TvShow>> getAnimationTvShows() async {
    endpoint = "discover/tv";
    final url = "$baseUrl$endpoint$key&page=$animationTvPage&with_genres=${16}";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'] as List;
      final List<TvShow> tvShowList = data.map((e) => TvShow.fromJson(e)).toList();
      animationTvPage++;
      return tvShowList;
    }
    throw Exception("Fail");
  }
}

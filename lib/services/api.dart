import 'dart:convert';
import 'package:netflix_clone/models/movie_detail.dart';
import 'package:netflix_clone/models/movie_recommendation.dart';
import 'package:netflix_clone/models/search_model.dart';
import 'package:netflix_clone/models/tv_show.dart';
import 'package:netflix_clone/models/tv_show_detail.dart';
import 'package:netflix_clone/models/tv_show_recommendation.dart';
import 'package:netflix_clone/util/constants.dart';
import 'package:netflix_clone/models/movie.dart';
import 'package:http/http.dart' as http;

late String endpoint;

class ApiService {
  int popularPage = 1;
  int topRatedPage = 1;
  int actionPage = 1;

  int airingTvPage = 1;
  int dramaTvPage = 1;
  int animationTvPage = 1;

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

  Future<List<Movie>> getTopSearches() async {
    endpoint = "movie/popular";
    final url = "$baseUrl$endpoint$key";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'] as List;
      final List<Movie> movieList = data.map((e) => Movie.fromJson(e)).toList();
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
      final List<TvShow> tvShowList =
          data.map((e) => TvShow.fromJson(e)).toList();
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
      final List<TvShow> tvShowList =
          data.map((e) => TvShow.fromJson(e)).toList();
      animationTvPage++;
      return tvShowList;
    }
    throw Exception("Fail");
  }

  Future<SearchModel> getSearchedMovie(String searchText) async {
    endpoint = "search/movie";
    final url = '$baseUrl$endpoint$key&query=$searchText';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return SearchModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Fail');
  }

  Future<SearchModel> getSearchedTvShow(String searchText) async {
    endpoint = "search/tv";
    final url = '$baseUrl$endpoint$key&query=$searchText';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return SearchModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Fail');
  }

  Future<MovieDetail> getMovieDetail(int id) async {
    final endPoint = 'movie/$id';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return MovieDetail.fromJson(jsonDecode(response.body));
    }
    throw Exception('Fail');
  }

  Future<MovieRecommendation> getMovieRecommendations(int id) async {
    final endPoint = 'movie/$id/recommendations';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return MovieRecommendation.fromJson(jsonDecode(response.body));
    }
    throw Exception('Fail');
  }

  Future<TvShowDetail> getTvShowDetail(int id) async {
    final endPoint = 'tv/$id';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return TvShowDetail.fromJson(jsonDecode(response.body));
    }
    throw Exception('Fail');
  }

  Future<TvShowRecommendation> getTvShowRecommendations(int id) async {
    final endPoint = 'tv/$id/recommendations';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return TvShowRecommendation.fromJson(jsonDecode(response.body));
    }
    throw Exception('Fail');
  }

  Future<List<Movie>> getUpcomingMovies() async {
    endpoint = "movie/upcoming";
    final url = "$baseUrl$endpoint$key&region=US";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'] as List;
      final List<Movie> movieList = data.map((e) => Movie.fromJson(e)).toList();
      return movieList;
    }
    throw Exception("Fail");
  }
}

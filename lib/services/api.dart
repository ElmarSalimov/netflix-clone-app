import 'dart:convert';

import 'package:netflix_clone/util/constants.dart';
import 'package:netflix_clone/models/upcoming_movie.dart';
import 'package:http/http.dart' as http;

String endpoint = "movie/upcoming";

class ApiService {
  Future<UpcomingMovie> getUpcomingMovies() async {
    final url = "$baseUrl$endpoint$key";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return UpcomingMovie.fromJson(jsonDecode(response.body));
    }
    throw {Exception("Fail")};
  }
}

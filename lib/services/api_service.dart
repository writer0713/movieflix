import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieflix/models/movie.dart';
import 'package:movieflix/models/movie_details.dart';

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String popular = "popular";
  static const String playing = "now-playing";
  static const String coming = "coming-soon";

  static Future<List<Movie>> getPopularMovies() async {
    final url = Uri.parse('$baseUrl/$popular');
    final response = await http.get(url);
    List<Movie> movies = [];

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var movieModel = MovieModel.fromJson(json);
      for (var movie in movieModel.results!) {
        movies.add(movie);
      }
      return movies;
    }
    throw Error();
  }

  static Future<List<Movie>> getPlayingMovies() async {
    final url = Uri.parse('$baseUrl/$playing');
    final response = await http.get(url);
    List<Movie> movies = [];

    if (response.statusCode != 200) {
      throw Error();
    }

    var json = jsonDecode(response.body);
    var movieModel = MovieModel.fromJson(json);
    for (var movie in movieModel.results!) {
      movies.add(movie);
    }
    return movies;
  }

  static Future<List<Movie>> getComingMovies() async {
    final url = Uri.parse('$baseUrl/$coming');
    final response = await http.get(url);
    List<Movie> movies = [];

    if (response.statusCode != 200) {
      throw Error();
    }

    var json = jsonDecode(response.body);
    var movieModel = MovieModel.fromJson(json);
    for (var movie in movieModel.results!) {
      movies.add(movie);
    }
    return movies;
  }

  static Future<MovieDetail> getMovieDetails(int id) async {
    final url = Uri.parse('$baseUrl/movie?id=$id');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Error();
    }

    var json = jsonDecode(response.body);
    var movieDetails = MovieDetail.fromJson(json);

    return movieDetails;
  }
}

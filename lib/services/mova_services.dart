import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/mova_model.dart';

class MovieServices {
  static const String _baseUrl = "https://api.themoviedb.org/3";
  static const String _apiKey = "API_AKU";   // GANTI API DISINI

  /// POPULAR MOVIES
  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse("$_baseUrl/movie/popular?api_key=$_apiKey&language=en-US&page=1"),
    );

    if (response.statusCode == 200) {
      final results = jsonDecode(response.body)['results'];
      return results.map<Movie>((m) => Movie.fromMap(m)).toList();
    } else {
      throw Exception("Failed to load popular movies");
    }
  }

  /// UPCOMING MOVIES
  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(
      Uri.parse("$_baseUrl/movie/upcoming?api_key=$_apiKey&language=en-US&page=1"),
    );

    if (response.statusCode == 200) {
      final results = jsonDecode(response.body)['results'];
      return results.map<Movie>((m) => Movie.fromMap(m)).toList();
    } else {
      throw Exception("Failed to load upcoming movies");
    }
  }

  /// TOP RATED MOVIES
  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(
      Uri.parse("$_baseUrl/movie/top_rated?api_key=$_apiKey&language=en-US&page=1"),
    );

    if (response.statusCode == 200) {
      final results = jsonDecode(response.body)['results'];
      return results.map<Movie>((m) => Movie.fromMap(m)).toList();
    } else {
      throw Exception("Failed to load top rated movies");
    }
  }

  /// MOVIE DETAILS + CAST
  Future<Map<String, dynamic>> getMovieDetails(int movieId) async {
    final detailResponse = await http.get(
      Uri.parse("$_baseUrl/movie/$movieId?api_key=$_apiKey&language=en-US"),
    );

    final castResponse = await http.get(
      Uri.parse("$_baseUrl/movie/$movieId/credits?api_key=$_apiKey&language=en-US"),
    );

    if (detailResponse.statusCode == 200 && castResponse.statusCode == 200) {
      final details = jsonDecode(detailResponse.body);
      final cast = jsonDecode(castResponse.body)['cast'];

      return {
        "details": details,
        "cast": cast,
      };
    } else {
      throw Exception("Failed to load movie details");
    }
  }

  /// ✔ FETCH GENRE NAME
  static Future<List<String>> fetchGenres(int movieId) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/movie/$movieId?api_key=$_apiKey&language=en-US"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List genres = data["genres"] ?? [];
      return genres.map((g) => g["name"].toString()).toList();
    } else {
      throw Exception("Failed to load genres");
    }
  }

  /// biar bisa nampilin trailer di detail screen pake api
  /// cek apakah itu movie atau tv show
  Future<String?> getMovieTrailerKey(int id, String mediaType) async {
  final endpoint = mediaType == "tv" ? "tv" : "movie";

  final response = await http.get(
    Uri.parse("$_baseUrl/$endpoint/$id/videos?api_key=$_apiKey&language=en-US"),
  );

  if (response.statusCode == 200) {
    final results = jsonDecode(response.body)['results'];

    final trailer = results.firstWhere(
      (video) => video['type'] == "Trailer" && video['site'] == "YouTube",
      orElse: () => null,
    );

    return trailer != null ? trailer['key'] : null;
  } else {
    throw Exception("Failed to load trailer");
  }
}


}

import 'package:flutter_dotenv/flutter_dotenv.dart';

class TmdbApi {
  static String get apiKey => dotenv.env['TMDB_API_KEYb9ea3027a8231dc54d52fc2e2ce92429'] ?? '';
  static String get accessToken => dotenv.env['eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiOWVhMzAyN2E4MjMxZGM1NGQ1MmZjMmUyY2U5MjQyOSIsIm5iZiI6MTc2Mzk1MzU5My43NzUsInN1YiI6IjY5MjNjYmI5ZDE2MzRhOTNhNWEzYjVmNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.L2ZVJzSlfe0yC2h1Y9QvP87YSyI_2jWPbak-VL7tuE4'] ?? '';

  /// Base URL
  static const String baseUrl = "https://api.themoviedb.org/3";

  /// Base Image URL
  static const String imageBase = "https://image.tmdb.org/t/p/w500";

  static String imageUrl(String path) => "$imageBase$path";
}

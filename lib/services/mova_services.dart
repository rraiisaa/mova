// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:mova_app/models/mova_model.dart';
// import '../core/tmdb_api.dart';

// class MovaServices {
//   static const _base = 'https://api.themoviedb.org/3';

//   Future<List<MovaModel>> fetchNowPlaying() async {
//     final url = Uri.parse('$_base/movie/now_playing?api_key=${TmdbApi.apiKey()}&language=en-US&page=1');
//     final resp = await http.get(url);
//     if (resp.statusCode == 200) {
//       final data = jsonDecode(resp.body);
//       final List results = data['results'];
//       return results.map((e) => MovaModel.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load now playing');
//     }
//   }

//   Future<List<MovaModel>> fetchPopular() async {
//     final url = Uri.parse('$_base/movie/popular?api_key=${TmdbApi.apiKey()}&language=en-US&page=1');
//     final resp = await http.get(url);
//     if (resp.statusCode == 200) {
//       final data = jsonDecode(resp.body);
//       final List results = data['results'];
//       return results.map((e) => MovaModel.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load popular');
//     }
//   }

//   Future<List<MovaModel>> fetchTopRated() async {
//     final url = Uri.parse('$_base/movie/top_rated?api_key=${TmdbApi.apiKey()}&language=en-US&page=1');
//     final resp = await http.get(url);
//     if (resp.statusCode == 200) {
//       final data = jsonDecode(resp.body);
//       final List results = data['results'];
//       return results.map((e) => MovaModel.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load top rated');
//     }
//   }
// }

class Movie {
  final String title;
  final String backDropPath;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final List<dynamic> genreIds;

  Movie({
    required this.title,
    required this.backDropPath,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.genreIds,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] ?? '',
      backDropPath: map['backdrop_path'] ?? '',
      overview: map['overview'] ?? '',
      posterPath: map['poster_path'] ?? '',
      voteAverage: (map['vote_average'] ?? 0).toDouble(),
      genreIds: map['genre_ids'] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'backDropPath': backDropPath,
      'overview': overview,
      'posterPath': posterPath,
      'voteAverage': voteAverage,
    };
  }
}

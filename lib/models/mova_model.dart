class Movie {
  final String title;
  final String backDropPath;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final List<dynamic> genreIds;

  // Tambahan yang diperlukan screen details
  final String originalLanguage;
  final String releaseDate;
  final double popularity;

  Movie({
    required this.title,
    required this.backDropPath,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.genreIds,
    required this.originalLanguage,
    required this.releaseDate,
    required this.popularity,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] ?? '',
      backDropPath: map['backdrop_path'] ?? '',
      overview: map['overview'] ?? '',
      posterPath: map['poster_path'] ?? '',
      voteAverage: (map['vote_average'] ?? 0).toDouble(),
      genreIds: map['genre_ids'] ?? [],

      // Field tambahan dari API
      originalLanguage: map['original_language'] ?? '-',
      releaseDate: map['release_date'] ?? '-',
      popularity: (map['popularity'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'backDropPath': backDropPath,
      'overview': overview,
      'posterPath': posterPath,
      'voteAverage': voteAverage,
      'genreIds': genreIds,

      // Tambahan (opsional masuk ke map)
      'originalLanguage': originalLanguage,
      'releaseDate': releaseDate,
      'popularity': popularity,
    };
  }
}

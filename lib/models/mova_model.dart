class Movie {
  final int id;
  final String title;
  final String backDropPath;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final String mediaType;
  final List<dynamic> genreIds;

  final String originalLanguage;
  final String releaseDate;
  final double popularity;

  Movie({
    required this.id,
    required this.title,
    required this.backDropPath,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.genreIds,
    required this.originalLanguage,
    required this.releaseDate,
    required this.popularity,
    required this.mediaType,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      backDropPath: map['backdrop_path'] ?? '',
      overview: map['overview'] ?? '',
      posterPath: map['poster_path'] ?? '',
      voteAverage: (map['vote_average'] ?? 0).toDouble(),
      genreIds: map['genre_ids'] ?? [],
      originalLanguage: map['original_language'] ?? '',
      releaseDate: map['release_date'] ?? '',
      popularity: (map['popularity'] ?? 0).toDouble(),
      mediaType: map['media_type'] ?? 'movie',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'backdrop_path': backDropPath,
      'overview': overview,
      'poster_path': posterPath,
      'vote_average': voteAverage,
      'genre_ids': genreIds,
      'original_language': originalLanguage,
      'release_date': releaseDate,
      'popularity': popularity,
    };
  }
}

class MediaSynthesis {
  bool? adult;
  String? backdropPath;
  List<int> genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  num? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  num? voteAverage;
  int? voteCount;
  String? name;
  String? originalName;
  String? firstAirDate;
  List<String> originCountry;

  MediaSynthesis({
    this.adult,
    this.backdropPath,
    this.genreIds = const [],
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.name,
    this.originalName,
    this.firstAirDate,
    this.originCountry = const [],
  });

  factory MediaSynthesis.fromJson(Map<String, dynamic> json) => MediaSynthesis(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        genreIds: json['genre_ids'] == null ? [] : List<int>.from(json['genre_ids'].map((x) => x)),
        id: json['id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
        name: json['name'],
        originalName: json['original_name'],
        firstAirDate: json['first_air_date'],
        originCountry: json['origin_country'] == null
            ? []
            : List<String>.from(json['origin_country'].map((x) => x)),
      );
}

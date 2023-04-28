// class Movie {
//   bool? adult;
//   String? backdropPath;
//   List<int> genreIds;
//   int? id;
//   String? originalLanguage;
//   String? originalTitle;
//   String? originalName;
//   String? overview;
//   double? popularity;
//   String? posterPath;
//   String? releaseDate;
//   String? title;
//   String? name;
//   bool? video;
//   num? voteAverage;
//   int? voteCount;

//   Movie({
//     this.adult,
//     this.backdropPath,
//     this.genreIds = const [],
//     this.id,
//     this.originalLanguage,
//     this.originalTitle,
//     this.originalName,
//     this.overview,
//     this.popularity,
//     this.posterPath,
//     this.releaseDate,
//     this.title,
//     this.name,
//     this.video,
//     this.voteAverage,
//     this.voteCount,
//   });

//   factory Movie.fromJson(Map<String, dynamic> json) => Movie(
//         adult: json['adult'],
//         backdropPath: json['backdrop_path'],
//         genreIds: json['genre_ids'] == null ? [] : List<int>.from(json['genre_ids'].map((x) => x)),
//         // genreIds: json['genre_ids'] == null ? [] : json['genre_ids'].cast<int>(),
//         id: json['id'],
//         originalLanguage: json['original_language'],
//         originalTitle: json['original_title'],
//         originalName: json['original_name'],
//         overview: json['overview'],
//         popularity: json['popularity'],
//         posterPath: json['poster_path'],
//         releaseDate: json['release_date'],
//         title: json['title'],
//         name: json['name'],
//         video: json['video'],
//         voteAverage: json['vote_average'],
//         voteCount: json['vote_count'],
//       );
// }

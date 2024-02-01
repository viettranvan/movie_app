import 'package:movie_app/models/models.dart';

class ArtistDetails {
  bool? adult;
  List<String> alsoKnownAs;
  String? biography;
  String? birthday;
  String? deathday;
  int? gender;
  String? homepage;
  int? id;
  String? imdbId;
  String? knownForDepartment;
  String? name;
  String? placeOfBirth;
  num? popularity;
  String? profilePath;
  Images? images;
  MultipleMedia? movieCredits;
  MultipleMedia? combinedCredits;
  MultipleMedia? tvCredits;

  ArtistDetails({
    this.adult,
    this.alsoKnownAs = const [],
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdbId,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.popularity,
    this.profilePath,
    this.images,
    this.movieCredits,
    this.combinedCredits,
    this.tvCredits,
  });

  factory ArtistDetails.fromJson(Map<String, dynamic> json) => ArtistDetails(
        adult: json['adult'],
        alsoKnownAs: json['also_known_as'] == null
            ? []
            : List<String>.from(json['also_known_as'].map((x) => x)),
        biography: json['biography'],
        birthday: json['birthday'],
        deathday: json['deathday'],
        gender: json['gender'],
        homepage: json['homepage'],
        id: json['id'],
        imdbId: json['imdb_id'],
        knownForDepartment: json['known_for_department'],
        name: json['name'],
        placeOfBirth: json['place_of_birth'],
        popularity: json['popularity'],
        profilePath: json['profile_path'],
        images: json['images'] == null ? null : Images.fromJson(json['images']),
        movieCredits:
            json['movie_credits'] == null ? null : MultipleMedia.fromJson(json['movie_credits']),
        combinedCredits: json['combined_credits'] == null
            ? null
            : MultipleMedia.fromJson(json['combined_credits']),
        tvCredits: json['tv_credits'] == null ? null : MultipleMedia.fromJson(json['tv_credits']),
      );
}

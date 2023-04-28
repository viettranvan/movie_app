import 'package:movie_app/model/model.dart';

class MediaArtist {
  String? profilePath;
  bool? adult;
  int? id;
  List<MediaSynthesis> knownFor;
  String? name;
  num? popularity;

  MediaArtist({
    this.profilePath,
    this.adult,
    this.id,
    this.knownFor = const [],
    this.name,
    this.popularity,
  });

  factory MediaArtist.fromJson(Map<String, dynamic> json) => MediaArtist(
        profilePath: json['profile_path'],
        adult: json['adult'],
        id: json['id'],
        knownFor: json['known_for'] == null
            ? []
            : List<MediaSynthesis>.from(json['known_for'].map((x) => MediaSynthesis.fromJson(x))),
        name: json['name'],
        popularity: json['popularity'].toDouble(),
      );
}

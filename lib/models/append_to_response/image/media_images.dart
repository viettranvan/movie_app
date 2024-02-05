import 'package:movie_app/models/models.dart';

class MediaImages {
  List<ImageResult> profiles;
  List<ImageResult> backdrops;
  List<ImageResult> logos;
  List<ImageResult> posters;

  MediaImages({
    this.profiles = const [],
    this.backdrops = const [],
    this.logos = const [],
    this.posters = const [],
  });

  factory MediaImages.fromJson(Map<String, dynamic> json) => MediaImages(
        profiles: json['profiles'] == null
            ? []
            : List<ImageResult>.from(json['profiles'].map((x) => ImageResult.fromJson(x))),
        backdrops: json['backdrops'] == null
            ? []
            : List<ImageResult>.from(json['backdrops'].map((x) => ImageResult.fromJson(x))),
        logos: json['logos'] == null
            ? []
            : List<ImageResult>.from(json['logos'].map((x) => ImageResult.fromJson(x))),
        posters: json['posters'] == null
            ? []
            : List<ImageResult>.from(json['posters'].map((x) => ImageResult.fromJson(x))),
      );
}

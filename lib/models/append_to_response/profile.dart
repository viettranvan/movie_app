class Profile {
  double? aspectRatio;
  int? height;
  String? iso6391;
  String? filePath;
  num? voteAverage;
  int? voteCount;
  int? width;

  Profile({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        aspectRatio: json['aspect_ratio'],
        height: json['height'],
        iso6391: json['iso_639_1'],
        filePath: json['file_path'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
        width: json['width'],
      );
}

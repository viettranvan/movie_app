class GenreMedia {
  List<Genre>? genres;

  GenreMedia({
    this.genres,
  });

  factory GenreMedia.fromJson(Map<String, dynamic> json) => GenreMedia(
        genres: json["genres"] == null
            ? []
            : List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
      );
}

class Genre {
  int? id;
  String? name;

  Genre({
    this.id,
    this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );
}

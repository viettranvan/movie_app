import 'package:movie_app/models/genre/genre.dart';
import 'package:movie_app/models/media/media.dart';

class MultipleDetails {
  bool? adult;
  String? backdropPath;
  BelongsToCollection? belongsToCollection;
  int? budget;
  List<Genre> genres;
  String? homepage;
  int? id;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  num? popularity;
  String? posterPath;
  List<ProductionCompany> productionCompanies;
  List<ProductionCountry> productionCountries;
  String? releaseDate;
  int? revenue;
  int? runtime;
  List<SpokenLanguage> spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  num? voteAverage;
  int? voteCount;
  List<CreatedBy> createdBy; // tv
  List<int> episodeRunTime;
  String? firstAirDate;
  bool? inProduction;
  List<String> languages;
  String? lastAirDate;
  LastEpisodeToAir? lastEpisodeToAir;
  String? name;
  NextEpisodeToAir? nextEpisodeToAir;
  List<Network> networks;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String> originCountry;
  String? originalName;
  List<Season> seasons;
  String? type;

  MultipleDetails({
    this.adult, //movie
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres = const [],
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies = const [],
    this.productionCountries = const [],
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages = const [],
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.createdBy = const [], //tv
    this.episodeRunTime = const [],
    this.firstAirDate,
    this.inProduction,
    this.languages = const [],
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks = const [],
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry = const [],
    this.originalName,
    this.seasons = const [],
    this.type,
  });

  factory MultipleDetails.fromJson(Map<String, dynamic> json) => MultipleDetails(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        belongsToCollection: json['belongs_to_collection'] == null
            ? null
            : BelongsToCollection.fromJson(json['belongs_to_collection']),
        budget: json['budget'],
        genres: json['genres'] == null
            ? []
            : List<Genre>.from(json['genres'].map((x) => Genre.fromJson(x))),
        homepage: json['homepage'],
        id: json['id'],
        imdbId: json['imdb_id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity']?.toDouble(),
        posterPath: json['poster_path'],
        productionCompanies: json['production_companies'] == null
            ? []
            : List<ProductionCompany>.from(
                json['production_companies'].map((x) => ProductionCompany.fromJson(x))),
        productionCountries: json['production_countries'] == null
            ? []
            : List<ProductionCountry>.from(
                json['production_countries'].map((x) => ProductionCountry.fromJson(x))),
        releaseDate: json['release_date'],
        revenue: json['revenue'],
        runtime: json['runtime'],
        spokenLanguages: List<SpokenLanguage>.from(
            json['spoken_languages'].map((x) => SpokenLanguage.fromJson(x))),
        status: json['status'],
        tagline: json['tagline'],
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average'].toDouble(),
        voteCount: json['vote_count'],
        createdBy: json['created_by'] == null
            ? []
            : List<CreatedBy>.from(json['created_by'].map((x) => CreatedBy.fromJson(x))),
        episodeRunTime: json['episode_run_time'] == null
            ? []
            : List<int>.from(json['episode_run_time'].map((x) => x)),
        firstAirDate: json['first_air_date'],
        inProduction: json['in_production'],
        languages:
            json['languages'] == null ? [] : List<String>.from(json['languages'].map((x) => x)),
        lastAirDate: json['last_air_date'],
        lastEpisodeToAir: json['last_episode_to_air'] == null
            ? null
            : LastEpisodeToAir.fromJson(json['last_episode_to_air']),
        name: json['name'],
        nextEpisodeToAir: json['next_episode_to_air'] == null
            ? null
            : NextEpisodeToAir.fromJson(json['next_episode_to_air']),
        networks: json['networks'] == null
            ? []
            : List<Network>.from(json['networks'].map((x) => Network.fromJson(x))),
        numberOfEpisodes: json['number_of_episodes'],
        numberOfSeasons: json['number_of_seasons'],
        originCountry: json['origin_country'] == null
            ? []
            : List<String>.from(json['origin_country'].map((x) => x)),
        originalName: json['original_name'],
        seasons: json['seasons'] == null
            ? []
            : List<Season>.from(json['seasons'].map((x) => Season.fromJson(x))),
        type: json['type'],
      );
}

class NextEpisodeToAir {
  NextEpisodeToAir();
  factory NextEpisodeToAir.fromJson(Map<String, dynamic> json) => NextEpisodeToAir();
}

class BelongsToCollection {
  BelongsToCollection();
  factory BelongsToCollection.fromJson(Map<String, dynamic> json) => BelongsToCollection();
}

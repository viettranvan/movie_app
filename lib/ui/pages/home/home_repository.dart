import 'package:movie_app/api/src/artist/artist.dart';
import 'package:movie_app/api/src/movie/movie_service.dart';
import 'package:movie_app/api/src/tv/tv_service.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/utils.dart';

class HomeRepository {
  final RestApiClient restApiClient;
  HomeRepository({
    required this.restApiClient,
  });

  Future<ListResponse<MultipleMedia>> getPopularMovie({
    required String language,
    required int page,
    required String region,
  }) async {
    return MovieService(apiClient: restApiClient).getPopularMovie(
      language: language,
      page: page,
      region: region,
    );
  }

  Future<ListResponse<MultipleMedia>> getTrendingMovie({
    required String mediaType,
    required String timeWindow,
    required int page,
    required String language,
    required bool includeAdult,
  }) async {
    return MovieService(apiClient: restApiClient).getTrendingMovie(
      mediaType: mediaType,
      timeWindow: timeWindow,
      page: page,
      language: language,
      includeAdult: includeAdult,
    );
  }

  Future<ListResponse<MultipleMedia>> getNowPlayingTv({
    required String language,
    required int page,
  }) async {
    return TvService(apiClient: restApiClient).getNowPlayingTv(
      language: language,
      page: page,
    );
  }

  Future<ListResponse<MultipleMedia>> getDiscoverTv({
    required String language,
    required int page,
    List<int> withGenres = const [],
  }) async {
    return TvService(apiClient: restApiClient).getDiscoverTv(
      language: language,
      page: page,
      withGenres: withGenres,
    );
  }

  Future<ListResponse<MultipleMedia>> getDiscoverMovie({
    required String language,
    required int page,
    List<int> withGenres = const [],
  }) async {
    return MovieService(apiClient: restApiClient).getDiscoverMovie(
      language: language,
      page: page,
      withGenres: withGenres,
    );
  }

  Future<ListResponse<MediaArtist>> getPopularArtist({
    required String language,
    required int page,
  }) async {
    return ArtistService(apiClient: restApiClient).getPopularArtist(
      language: language,
      page: page,
    );
  }

  Future<ListResponse<MultipleMedia>> getTopTv({
    required String language,
    required int page,
  }) async {
    return TvService(apiClient: restApiClient).getTopTv(
      language: language,
      page: page,
    );
  }

  Future<ListResponse<MultipleMedia>> getUpcomingMovie({
    required String language,
    required int page,
    required String region,
  }) async {
    return MovieService(apiClient: restApiClient).getUpcomingMovie(
      language: language,
      page: page,
      region: region,
    );
  }
}

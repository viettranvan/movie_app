import 'package:movie_app/api/src/artist/index.dart';
import 'package:movie_app/api/src/genre/genre_service.dart';
import 'package:movie_app/api/src/movie/movie_service.dart';
import 'package:movie_app/api/src/tv/tv_service.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/utils/index.dart';

class HomeRepository {
  final RestApiClient restApiClient;
  HomeRepository({
    required this.restApiClient,
  });

  Future<ListResponse<Genre>> getGenreMovie({
    required String language,
  }) async {
    return GenreService(apiClient: restApiClient).getGenreMovie(
      language: language,
    );
  }

  Future<ListResponse<Genre>> getGenreTv({
    required String language,
  }) async {
    return GenreService(apiClient: restApiClient).getGenreTv(
      language: language,
    );
  }

  Future<ListResponse<MediaSynthesis>> getPopularMovie({
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

  Future<ListResponse<TrendingSynthesis>> getTrendingMovie({
    required String mediaType,
    required String timeWindow,
    required int page,
    required String language,
  }) async {
    return MovieService(apiClient: restApiClient).getTrendingMovie(
      mediaType: mediaType,
      timeWindow: timeWindow,
      page: page,
      language: language,
    );
  }

  Future<ListResponse<MediaSynthesis>> getNowPlayingTv({
    required String language,
    required int page,
  }) async {
    return TvService(apiClient: restApiClient).getNowPlayingTv(
      language: language,
      page: page,
    );
  }

  Future<ListResponse<MediaSynthesis>> getBestDramaTv({
    required String language,
    required int page,
    required List<int> withGenres,
    // required String region,
  }) async {
    return TvService(apiClient: restApiClient).getBestDramaTv(
      language: language,
      page: page,
      withGenres: withGenres,
      // region: region,
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

  Future<ListResponse<MediaSynthesis>> getTopTv({
    required String language,
    required int page,
  }) async {
    return TvService(apiClient: restApiClient).getTopTv(
      language: language,
      page: page,
    );
  }

  Future<ListResponse<MediaSynthesis>> getUpcomingMovie({
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

  Future<ObjectResponse<MediaSynthesisDetails>> getDetailsTv({
    required String language,
    required int tvId,
    String? appendToResponse,
  }) async {
    return TvService(apiClient: restApiClient).getDetailsTv(
      language: language,
      tvId: tvId,
      appendToResponse: appendToResponse,
    );
  }
}

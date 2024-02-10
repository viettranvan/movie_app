import 'package:movie_app/api/api.dart';
import 'package:movie_app/api/src/provider/provider.dart';
import 'package:movie_app/api/src/src.dart';
import 'package:movie_app/api/src/state/state_service.dart';
import 'package:movie_app/api/src/trailer/trailer.dart';
import 'package:movie_app/api/src/watch_list/watch_list.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/utils.dart';

class ExploreRepository {
  final RestApiClient restApiClient;
  ExploreRepository({
    required this.restApiClient,
  });

  Future<ObjectResponse<MediaGenre>> getGenreMovie({
    required String language,
  }) async {
    return GenreService(apiClient: restApiClient).getGenreMovie(
      language: language,
    );
  }

  Future<ObjectResponse<MediaGenre>> getGenreTv({
    required String language,
  }) async {
    return GenreService(apiClient: restApiClient).getGenreTv(
      language: language,
    );
  }

  Future<ListResponse<MultipleMedia>> getTopRatedMovie({
    required String language,
    required int page,
    required String region,
  }) async {
    return MovieService(apiClient: restApiClient).getTopRatedMovie(
      language: language,
      page: page,
      region: region,
    );
  }

  Future<ListResponse<MultipleMedia>> getNowPlayingMovie({
    required String language,
    required int page,
    required String region,
  }) async {
    return MovieService(apiClient: restApiClient).getNowPlayingMovie(
      language: language,
      page: page,
      region: region,
    );
  }

  Future<ListResponse<MultipleMedia>> getPopularTv({
    required String language,
    required int page,
    List<int> withGenres = const [],
  }) async {
    return TvService(apiClient: restApiClient).getPopularTv(
      language: language,
      page: page,
      withGenres: withGenres,
    );
  }

  Future<ListResponse<MediaTrailer>> getTrailerMovie({
    required int movieId,
    required String language,
  }) async {
    return TrailerService(apiClient: restApiClient).getTrailerMovie(
      movieId: movieId,
      language: language,
    );
  }

  Future<ListResponse<MediaTrailer>> getTrailerTv({
    required int seriesId,
    required String language,
    String? includeVideoLanguage,
  }) async {
    return TrailerService(apiClient: restApiClient).getTrailerTv(
      seriesId: seriesId,
      language: language,
      includeVideoLanguage: includeVideoLanguage,
    );
  }

  Future<ObjectResponse<MediaState>> getMovieState({
    required int movieId,
    required String sessionId,
  }) async {
    return StateService(apiClient: restApiClient).getMovieState(
      movieId: movieId,
      sessionId: sessionId,
    );
  }

  Future<ObjectResponse<MediaState>> getTvState({
    required int seriesId,
    required String sessionId,
  }) async {
    return StateService(apiClient: restApiClient).getTvState(
      seriesId: seriesId,
      sessionId: sessionId,
    );
  }

  Future<ObjectResponse<APIResponse>> addWatchList({
    required int accountId,
    required String sessionId,
    required String mediaType,
    required int mediaId,
    required bool watchlist,
  }) async {
    return WatchListService(apiClient: restApiClient).addWatchList(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: mediaType,
      mediaId: mediaId,
      watchlist: watchlist,
    );
  }

  Future<ObjectResponse<ArtistDetails>> getDetailsArtist({
    required int personId,
    required String language,
    String? appendToResponse,
  }) async {
    return ArtistService(apiClient: restApiClient).getDetailsArtist(
      personId: personId,
      language: language,
      appendToResponse: appendToResponse,
    );
  }

  Future<ListResponse<MediaProvider>> getMovieProvider({
    required String language,
    required String watchRegion,
  }) async {
    return ProviderService(apiClient: restApiClient).getMovieProvider(
      language: language,
      watchRegion: watchRegion,
    );
  }

  Future<ListResponse<MediaProvider>> getTvProvider({
    required String language,
    required String watchRegion,
  }) async {
    return ProviderService(apiClient: restApiClient).getTvProvider(
      language: language,
      watchRegion: watchRegion,
    );
  }
}

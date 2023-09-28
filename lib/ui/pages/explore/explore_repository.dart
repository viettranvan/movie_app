import 'package:movie_app/api/src/src.dart';
import 'package:movie_app/api/src/trailer/trailer.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/utils.dart';

class ExploreRepository {
  final RestApiClient restApiClient;
  ExploreRepository({
    required this.restApiClient,
  });
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
}

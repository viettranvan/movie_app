import 'package:movie_app/api/src/src.dart';
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
}

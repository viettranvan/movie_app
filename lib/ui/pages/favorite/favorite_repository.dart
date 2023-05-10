import 'package:movie_app/api/src/favorite/index.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/utils/utils.dart';

class FavoriteRepository {
  final RestApiClient restApiClient;
  FavoriteRepository({
    required this.restApiClient,
  });

  Future<ListResponse<MediaSynthesis>> getFavoriteMovie({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) async {
    return FavoriteService(apiClient: restApiClient).getFavoriteMovie(
      accountId: accountId,
      sessionId: sessionId,
      language: language,
      sortBy: sortBy,
      page: page,
    );
  }

  Future<ListResponse<MediaSynthesis>> getFavoriteTv({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) async {
    return FavoriteService(apiClient: restApiClient).getFavoriteTv(
      accountId: accountId,
      sessionId: sessionId,
      language: language,
      sortBy: sortBy,
      page: page,
    );
  }
}

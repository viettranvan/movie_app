import 'package:movie_app/api/api.dart';
import 'package:movie_app/api/src/favorite/favorite_request.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/rest_api_client/index.dart';

class FavoriteService {
  FavoriteService({required this.apiClient});
  APIClient apiClient;
  Future<ListResponse<MultipleMedia>> getFavoriteMovie({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) async {
    final request = FavoriteRequest.getFavoriteMovie(
      accountId: accountId,
      sessionId: sessionId,
      language: language,
      sortBy: sortBy,
      page: page,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MultipleMedia>> getFavoriteTv({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) async {
    final request = FavoriteRequest.getFavoriteTv(
      accountId: accountId,
      sessionId: sessionId,
      language: language,
      sortBy: sortBy,
      page: page,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }
}

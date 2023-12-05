import 'package:movie_app/api/api_client/index.dart';
import 'package:movie_app/api/src/watch_list/watch_list.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/utils.dart';

class WatchListService {
  WatchListService({required this.apiClient});
  APIClient apiClient;
  Future<ListResponse<MultipleMedia>> getWatchListMovie({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) async {
    final request = WatchListRequest.getWatchListMovie(
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

  Future<ListResponse<MultipleMedia>> getWatchListTv({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) async {
    final request = WatchListRequest.getWatchListTv(
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

  Future<ObjectResponse<APIResponse>> addWatchList({
    required int accountId,
    required String sessionId,
    required String mediaType,
    required int mediaId,
    required bool watchlist,
  }) async {
    final request = WatchListRequest.addWatchList(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: mediaType,
      mediaId: mediaId,
      watchlist: watchlist,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = APIResponse.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }
}

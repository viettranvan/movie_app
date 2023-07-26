import 'package:movie_app/api/src/watch_list/watch_list.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/utils.dart';

class WatchListRepository {
  final RestApiClient restApiClient;
  WatchListRepository({
    required this.restApiClient,
  });

  Future<ListResponse<MultipleMedia>> getWatchListMovie({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) async {
    return WatchListService(apiClient: restApiClient).getWatchListMovie(
      accountId: accountId,
      sessionId: sessionId,
      language: language,
      sortBy: sortBy,
      page: page,
    );
  }

  Future<ListResponse<MultipleMedia>> getWatchListTv({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) async {
    return WatchListService(apiClient: restApiClient).getWatchListTv(
      accountId: accountId,
      sessionId: sessionId,
      language: language,
      sortBy: sortBy,
      page: page,
    );
  }
}

import 'package:movie_app/api/src/watchlist/watchlist.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/utils.dart';

class WatchlistRepository {
  final RestApiClient restApiClient;
  WatchlistRepository({
    required this.restApiClient,
  });

  Future<ListResponse<MultipleMedia>> getWatchListMovie({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) async {
    return WatchlistService(apiClient: restApiClient).getWatchListMovie(
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
    return WatchlistService(apiClient: restApiClient).getWatchListTv(
      accountId: accountId,
      sessionId: sessionId,
      language: language,
      sortBy: sortBy,
      page: page,
    );
  }
}

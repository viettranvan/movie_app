import 'package:movie_app/api/api_client/index.dart';

class WatchListRequest {
  WatchListRequest._();

  static APIRequest getWatchListMovie({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/account/$accountId/watchlist/movies',
        parameters: {
          'account_id': accountId,
          'session_id': sessionId,
          'language': language,
          'sort_by': sortBy,
          'page': page,
        },
      );

  static APIRequest getWatchListTv({
    required String language,
    required int accountId,
    required String sessionId,
    String? sortBy,
    required int page,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/account/$accountId/watchlist/tv',
        parameters: {
          'account_id': accountId,
          'session_id': sessionId,
          'language': language,
          'sort_by': sortBy,
          'page': page,
        },
      );
}

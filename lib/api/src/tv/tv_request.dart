import 'package:movie_app/api/api.dart';

class TvRequest {
  TvRequest._();

  static APIRequest getBestDramaTv({
    required String language,
    required int page,
    required List<int> withGenres,
    // required String region,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/tv/on_the_air',
        parameters: {
          'language': language,
          'page': page,
          'with_genres': withGenres,
          // 'region': region,
        },
      );

  static APIRequest getNowPlayingTv({
    required String language,
    required int page,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/tv/airing_today',
        parameters: {
          'language': language,
          'page': page,
        },
      );

  static APIRequest getTopTv({
    required String language,
    required int page,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/tv/top_rated',
        parameters: {
          'language': language,
          'page': page,
        },
      );

  static APIRequest getDetailsTv({
    required String language,
    required int tvId,
    String? appendToResponse,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/tv/$tvId',
        parameters: {
          'language': language,
          'tv_id': tvId,
          'append_to_response': appendToResponse,
        },
      );
}

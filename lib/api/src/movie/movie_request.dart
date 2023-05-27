import 'package:movie_app/api/api.dart';

class MovieRequest {
  MovieRequest._();

  static APIRequest getPopularMovie({
    required String language,
    required int page,
    required String region,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/movie/popular',
        parameters: {
          'language': language,
          'page': page,
          'region': region,
        },
      );

  static APIRequest getTrendingMovie({
    required String mediaType,
    required String timeWindow,
    required int page,
    required String language,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/trending/$mediaType/$timeWindow',
        parameters: {
          'media_type': mediaType,
          'time_window': timeWindow,
          'page': page,
          'language': language,
        },
      );

  static APIRequest getUpcomingMovie({
    required String language,
    required int page,
    required String region,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/movie/upcoming',
        parameters: {
          'language': language,
          'page': page,
          'region': region,
        },
      );
}

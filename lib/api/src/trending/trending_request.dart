import 'package:movie_app/api/index.dart';

class TrendingRequest {
  TrendingRequest._();

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
          'page':page,
          'language': language,
        },
      );
}

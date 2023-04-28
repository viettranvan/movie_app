import 'package:movie_app/api/index.dart';

class UpcomingRequest {
  UpcomingRequest._();

  static APIRequest getUpcomingMovie({
    required String language,
    required int page,
    required String region,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/movie/upcoming',
        parameters: {
          'language':language,
          'page': page,
          'region': region,
        },
      );
}

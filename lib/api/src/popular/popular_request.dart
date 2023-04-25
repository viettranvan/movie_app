import 'package:movie_app/api/index.dart';

class PopularRequest {
  PopularRequest._();

  static APIRequest getPopularMovie({
    required String language,
    required int page,
    required String region,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/movie/popular',
        parameters: {
          'language':language,
          'page': page,
          'region': region,
        },
      );
}

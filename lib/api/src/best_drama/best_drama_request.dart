import 'package:movie_app/api/index.dart';

class BestDramaRequest {
  BestDramaRequest._();

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
}

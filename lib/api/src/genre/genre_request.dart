import 'package:movie_app/api/index.dart';

class GenreRequest {
  GenreRequest._();

  static APIRequest getGenreMovie({
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

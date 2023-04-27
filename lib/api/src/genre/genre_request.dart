import 'package:movie_app/api/index.dart';

class GenreRequest {
  GenreRequest._();

  static APIRequest getGenreMovie({
    required String language,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/genre/movie/list',
        parameters: {
          'language': language,
        },
      );

  static APIRequest getGenreTv({
    required String language,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/genre/tv/list',
        parameters: {
          'language': language,
        },
      );
}

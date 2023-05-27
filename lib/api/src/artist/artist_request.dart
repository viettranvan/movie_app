import 'package:movie_app/api/api.dart';

class ArtistRequest {
  ArtistRequest._();

  static APIRequest getPopularArtist({
    required String language,
    required int page,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/person/popular',
        parameters: {
          'language': language,
          'page': page,
        },
      );
}

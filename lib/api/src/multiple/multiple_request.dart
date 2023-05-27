import 'package:movie_app/api/api_client/index.dart';

class MultipleRequest {
  MultipleRequest._();

  static APIRequest searchMultipleMedia({
    required String query,
    required bool includeAdult,
    required String language,
    required int page,
  }) =>
      APIRequest(
        method: HTTPMethods.get,
        path: '/search/multi',
        parameters: {
          'query': query,
          'include_adult': includeAdult,
          'language': language,
          'page': page,
        },
      );
}

import 'package:movie_app/api/index.dart';

class PopularRequest {
  PopularRequest._();

  static APIRequest getPopularMovie() => APIRequest(
        method: HTTPMethods.get,
        path: '/movie/popular',
      );
}

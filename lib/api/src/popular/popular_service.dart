import 'package:movie_app/api/index.dart';
import 'package:movie_app/model/index.dart';

class PopularService {
  PopularService({required this.apiClient});

  APIClient apiClient;

  Future<List<Movie>> getPopularMovie() async {
    final request = PopularRequest.getPopularMovie();

    APIResponse response = await apiClient.execute(request: request);

    List<Movie> list =
        response.results.toList().map<Movie>((e) => Movie.fromJson(e)).toList();

    return list;
  }
}

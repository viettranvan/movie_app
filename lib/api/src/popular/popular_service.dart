import 'package:movie_app/api/index.dart';
import 'package:movie_app/model/index.dart';
import 'package:movie_app/utils/api_client/response_type.dart';

class PopularService {
  PopularService({required this.apiClient});
  APIClient apiClient;
  Future<ListResponse<Movie>> getPopularMovie({
    required String language,
    required int page,
    required String region,
  }) async {
    final request = PopularRequest.getPopularMovie(
      language: language,
      page: page,
      region: region,
    );
    final response = await apiClient.execute(request: request);
    final listResponse = response.results.toList().map<Movie>((e) => Movie.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }
}

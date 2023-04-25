// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movie_app/api/index.dart';
import 'package:movie_app/model/index.dart';
import 'package:movie_app/utils/index.dart';

class HomeRepository {
  final RestApiClient restApiClient;
  HomeRepository({
    required this.restApiClient,
  });
  Future<ListResponse<Movie>> getPopularMovie({
    required String language,
    required int page,
    required String region,
  }) async {
    return PopularService(apiClient: restApiClient).getPopularMovie(
      language: language,
      page: page,
      region: region,
    );
  }
}

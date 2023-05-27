import 'package:movie_app/api/api.dart';
import 'package:movie_app/api/src/movie/movie_request.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/rest_api_client/response_type.dart';

class MovieService {
  MovieService({required this.apiClient});
  APIClient apiClient;
  Future<ListResponse<MultipleMedia>> getPopularMovie({
    required String language,
    required int page,
    required String region,
  }) async {
    final request = MovieRequest.getPopularMovie(
      language: language,
      page: page,
      region: region,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MultipleMedia>> getTrendingMovie({
    required String mediaType,
    required String timeWindow,
    required int page,
    required String language,
  }) async {
    final request = MovieRequest.getTrendingMovie(
      mediaType: mediaType,
      timeWindow: timeWindow,
      page: page,
      language: language,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MultipleMedia>> getUpcomingMovie({
    required String language,
    required int page,
    required String region,
  }) async {
    final request = MovieRequest.getUpcomingMovie(
      language: language,
      page: page,
      region: region,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }
}

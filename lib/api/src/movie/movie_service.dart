import 'package:movie_app/api/index.dart';
import 'package:movie_app/api/src/movie/movie_request.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/utils/rest_api_client/response_type.dart';

class MovieService {
  MovieService({required this.apiClient});
  APIClient apiClient;
  Future<ListResponse<MediaSynthesis>> getPopularMovie({
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
        response.toList().map<MediaSynthesis>((e) => MediaSynthesis.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<TrendingSynthesis>> getTrendingMovie({
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
        response.toList().map<TrendingSynthesis>((e) => TrendingSynthesis.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MediaSynthesis>> getUpcomingMovie({
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
        response.toList().map<MediaSynthesis>((e) => MediaSynthesis.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }
}

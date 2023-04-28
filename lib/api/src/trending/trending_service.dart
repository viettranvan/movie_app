import 'package:movie_app/api/index.dart';
import 'package:movie_app/api/src/trending/trending_request.dart';
import 'package:movie_app/model/index.dart';
import 'package:movie_app/utils/api_client/response_type.dart';

class TrendingService {
  TrendingService({required this.apiClient});
  APIClient apiClient;
  Future<ListResponse<TrendingSynthesis>> getTrendingMovie({
    required String mediaType,
    required String timeWindow,
    required int page,
    required String language,
  }) async {
    final request = TrendingRequest.getTrendingMovie(
      mediaType: mediaType,
      timeWindow: timeWindow,
      page: page,
      language: language,
    );
    final response = await apiClient.execute(request: request);
    final listResponse = response.results.toList().map<TrendingSynthesis>((e) => TrendingSynthesis.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }
}

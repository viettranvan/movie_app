import 'package:movie_app/api/index.dart';
import 'package:movie_app/api/src/upcoming/index.dart';
import 'package:movie_app/model/index.dart';
import 'package:movie_app/utils/api_client/response_type.dart';

class UpcomingService {
  UpcomingService({required this.apiClient});
  APIClient apiClient;
  Future<ListResponse<MediaSynthesis>> getUpcomingMovie({
    required String language,
    required int page,
    required String region,
  }) async {
    final request = UpcomingRequest.getUpcomingMovie(
      language: language,
      page: page,
      region: region,
    );
    final response = await apiClient.execute(request: request);
    final listResponse = response.results.toList().map<MediaSynthesis>((e) => MediaSynthesis.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }
}

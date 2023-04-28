import 'package:movie_app/api/index.dart';
import 'package:movie_app/api/src/best_drama/index.dart';
import 'package:movie_app/model/index.dart';
import 'package:movie_app/utils/api_client/response_type.dart';

class BestDramaService {
  BestDramaService({required this.apiClient});
  APIClient apiClient;
  Future<ListResponse<MediaSynthesis>> getBestDramaTv({
      required String language,
    required int page,
    required List<int> withGenres,
    // required String region,
  }) async {
    final request = BestDramaRequest.getBestDramaTv(
      language: language,
      page: page,
      withGenres: withGenres,
      // region: region,
    );
    final response = await apiClient.execute(request: request);
    final listResponse = response.results.toList().map<MediaSynthesis>((e) => MediaSynthesis.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }
}

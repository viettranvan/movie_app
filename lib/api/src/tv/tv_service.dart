import 'package:movie_app/api/index.dart';
import 'package:movie_app/api/src/tv/index.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/utils/api_client/response_type.dart';

class TvService {
  TvService({required this.apiClient});
  APIClient apiClient;
  Future<ListResponse<MediaSynthesis>> getBestDramaTv({
    required String language,
    required int page,
    required List<int> withGenres,
    // required String region,
  }) async {
    final request = TvRequest.getBestDramaTv(
      language: language,
      page: page,
      withGenres: withGenres,
      // region: region,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MediaSynthesis>((e) => MediaSynthesis.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MediaSynthesis>> getNowPlayingTv({
    required String language,
    required int page,
  }) async {
    final request = TvRequest.getNowPlayingTv(
      language: language,
      page: page,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MediaSynthesis>((e) => MediaSynthesis.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MediaSynthesis>> getTopTv({
    required String language,
    required int page,
  }) async {
    final request = TvRequest.getTopTv(
      language: language,
      page: page,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MediaSynthesis>((e) => MediaSynthesis.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ObjectResponse<MediaSynthesisDetails>> getDetailsTv({
    required String language,
    required int tvId,
    String? appendToResponse,
  }) async {
    final request = TvRequest.getDetailsTv(
      tvId: tvId,
      language: language,
      appendToResponse: appendToResponse,
    );
    final response = await apiClient.execute(request: request);
    final objectResponse = MediaSynthesisDetails.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }
}

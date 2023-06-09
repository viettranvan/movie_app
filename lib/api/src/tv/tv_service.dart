import 'package:movie_app/api/api.dart';
import 'package:movie_app/api/src/tv/tv.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/rest_api_client/response_type.dart';

class TvService {
  TvService({required this.apiClient});
  APIClient apiClient;
  Future<ListResponse<MultipleMedia>> getBestDramaTv({
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
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MultipleMedia>> getNowPlayingTv({
    required String language,
    required int page,
  }) async {
    final request = TvRequest.getNowPlayingTv(
      language: language,
      page: page,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MultipleMedia>> getTopTv({
    required String language,
    required int page,
  }) async {
    final request = TvRequest.getTopTv(
      language: language,
      page: page,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ObjectResponse<MultipleDetails>> getDetailsTv({
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
    final objectResponse = MultipleDetails.fromJson(response.toObject());
    return ObjectResponse(object: objectResponse);
  }
}

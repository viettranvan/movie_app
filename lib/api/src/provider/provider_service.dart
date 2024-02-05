import 'package:movie_app/api/api_client/index.dart';
import 'package:movie_app/api/src/provider/provider.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/utils.dart';

class ProviderService {
  ProviderService({required this.apiClient});
  APIClient apiClient;
  Future<ListResponse<MediaProvider>> getMovieProvider({
    required String language,
    required String watchRegion,
  }) async {
    final request = ProviderRequest.getMovieProvider(
      language: language,
      watchRegion: watchRegion,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MediaProvider>((e) => MediaProvider.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<MediaProvider>> getTvProvider({
    required String language,
    required String watchRegion,
  }) async {
    final request = ProviderRequest.getTvProvider(
      language: language,
      watchRegion: watchRegion,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MediaProvider>((e) => MediaProvider.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }
}

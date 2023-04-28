import 'package:movie_app/api/index.dart';
import 'package:movie_app/api/src/artist/index.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/utils/api_client/response_type.dart';

class ArtistService {
  ArtistService({required this.apiClient});
  APIClient apiClient;
  Future<ListResponse<MediaArtist>> getPopularArtist({
    required String language,
    required int page,
  }) async {
    final request = ArtistRequest.getPopularArtist(
      language: language,
      page: page,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.results.toList().map<MediaArtist>((e) => MediaArtist.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }
}

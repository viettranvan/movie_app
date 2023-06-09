import 'package:movie_app/api/api.dart';
import 'package:movie_app/api/src/artist/artist.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/rest_api_client/response_type.dart';

class ArtistService {
  ArtistService({required this.apiClient});
  APIClient apiClient;
  Future<ListResponse<MultipleMedia>> getPopularArtist({
    required String language,
    required int page,
  }) async {
    final request = ArtistRequest.getPopularArtist(
      language: language,
      page: page,
    );
    final response = await apiClient.execute(request: request);
    final listResponse =
        response.toList().map<MultipleMedia>((e) => MultipleMedia.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }
}

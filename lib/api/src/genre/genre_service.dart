import 'package:movie_app/api/index.dart';
import 'package:movie_app/api/src/genre/genre_request.dart';
import 'package:movie_app/model/media_genre.dart';
import 'package:movie_app/utils/index.dart';

class GenreService {
  GenreService({required this.apiClient});
  APIClient apiClient;
  Future<ListResponse<Genre>> getGenreMovie({
    required String language,
  }) async {
    final request = GenreRequest.getGenreMovie(
      language: language,
    );
    final response = await apiClient.execute(request: request);
    final listResponse = response.genres.toList().map<Genre>((e) => Genre.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }

  Future<ListResponse<Genre>> getGenreTv({
    required String language,
  }) async {
    final request = GenreRequest.getGenreTv(
      language: language,
    );
    final response = await apiClient.execute(request: request);
    final listResponse = response.genres.toList().map<Genre>((e) => Genre.fromJson(e)).toList();
    return ListResponse(list: listResponse);
  }
}

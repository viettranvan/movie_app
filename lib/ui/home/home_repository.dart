// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movie_app/api/index.dart';
import 'package:movie_app/api/src/genre/genre_service.dart';
import 'package:movie_app/api/src/trending/trending_service.dart';
import 'package:movie_app/model/media_genre.dart';
import 'package:movie_app/model/index.dart';
import 'package:movie_app/utils/index.dart';

class HomeRepository {
  final RestApiClient restApiClient;
  HomeRepository({
    required this.restApiClient,
  });
  Future<ListResponse<Media>> getPopularMovie({
    required String language,
    required int page,
    required String region,
  }) async {
    return PopularService(apiClient: restApiClient).getPopularMovie(
      language: language,
      page: page,
      region: region,
    );
  }

  Future<ListResponse<TrendingSynthesis>> getTrendingMovie({
    required String mediaType,
    required String timeWindow,
    required int page,
    required String language,
  }) async {
    return TrendingService(apiClient: restApiClient).getTrendingMovie(
      mediaType: mediaType,
      timeWindow: timeWindow,
      page: page,
      language: language,
    );
  }

  Future<ListResponse<Genre>> getGenreMovie({
    required String language,
  }) async {
    return GenreService(apiClient: restApiClient).getGenreMovie(
      language: language,
    );
  }

  Future<ListResponse<Genre>> getGenreTv({
    required String language,
  }) async {
    return GenreService(apiClient: restApiClient).getGenreTv(
      language: language,
    );
  }
}

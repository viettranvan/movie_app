// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movie_app/api/index.dart';
import 'package:movie_app/api/src/best_drama/index.dart';
import 'package:movie_app/api/src/genre/genre_service.dart';
import 'package:movie_app/api/src/trending/trending_service.dart';
import 'package:movie_app/api/src/upcoming/index.dart';
import 'package:movie_app/model/index.dart';
import 'package:movie_app/utils/index.dart';

class HomeRepository {
  final RestApiClient restApiClient;
  HomeRepository({
    required this.restApiClient,
  });

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

  Future<ListResponse<MediaSynthesis>> getPopularMovie({
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

  Future<ListResponse<MediaSynthesis>> getBestDramaTv({
    required String language,
    required int page,
    required List<int> withGenres,
    // required String region,
  }) async {
    return BestDramaService(apiClient: restApiClient).getBestDramaTv(
      language: language,
      page: page,
      withGenres: withGenres,
      // region: region,
    );
  }

  Future<ListResponse<MediaSynthesis>> getUpcomingMovie({
    required String language,
    required int page,
    required String region,
  }) async {
    return UpcomingService(apiClient: restApiClient).getUpcomingMovie(
      language: language,
      page: page,
      region: region,
    );
  }
}

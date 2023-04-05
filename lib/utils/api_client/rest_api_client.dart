import 'package:dio/dio.dart';
import 'package:movie_app/api/index.dart';
import 'package:movie_app/utils/index.dart';

class RestApiClient extends APIClient {
  static final RestApiClient _instance = RestApiClient._();

  RestApiClient._();

  factory RestApiClient() => _instance;

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
    ),
  )..interceptors.add(APIInterceptor());

  @override
  Future<APIResponse> execute({required APIRequest request}) async {
    final options = Options(
      method: request.method.value,
      contentType: Headers.jsonContentType,
    );

    try {
      final response = await dio.request(
        request.path,
        queryParameters: request.parameters.addApiKey(),
        data: request.body,
        options: options,
      );

      return APIResponse.fromJson(response.data);
    } on DioError catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw APIError.fromJson(e.response?.data);

        default:
          throw APIError(statusMessage: e.message);
      }
    }
  }
}


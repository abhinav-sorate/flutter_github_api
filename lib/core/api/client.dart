import 'package:dio/dio.dart';
import 'package:flutter_github_api/core/api/api_endpoints.dart';
import 'package:flutter_github_api/core/api/interceptor.dart';

class ApiClient {
  final String baseUrl;
  late final Dio _dio;

  ApiClient({required this.baseUrl}) {
    _dio = _createDio();
  }

  DioInterceptor get _apiInterceptor => DioInterceptor();

  Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 5),
      ),
    );
    dio.interceptors.add(_apiInterceptor);

    dio.interceptors.add(
      LogInterceptor(
        request: false,
        requestBody: false,
        responseBody: true,
        error: true,
      ),
    );
    return dio;
  }

  // GET
  Future<Response<T>> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.get<T>(path, queryParameters: queryParameters);
  }

  // POST
  Future<Response<T>> post<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }
}

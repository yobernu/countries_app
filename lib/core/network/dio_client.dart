import 'package:dio/dio.dart';
import 'api_endpoints.dart';
import 'cache_interceptor.dart';

class DioClient {
  late Dio dio;

  DioClient({
    Dio? dio,
    bool enableLogging = true,
    bool enableCache = true,
  }) {
    this.dio = dio ??
        Dio(
          BaseOptions(
            baseUrl: ApiEndpoints.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: const {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        );

    if (enableLogging) {
      this.dio.interceptors.add(
            LogInterceptor(
              request: true,
              requestHeader: true,
              requestBody: true,
              responseHeader: true,
              responseBody: true,
              error: true,
            ),
          );
    }

    if (enableCache) {
      CacheInterceptorWrapper.getInterceptor().then(
        (interceptor) => this.dio.interceptors.add(interceptor),
      );
    }
  }
}
import 'package:dio/dio.dart';
import 'api_endpoints.dart';
import 'cache_interceptor.dart'; // We will implement this next

class DioClient {
  late Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(
          seconds: 10,
        ).inMilliseconds, // ✅ convert to int
        receiveTimeout: const Duration(
          seconds: 10,
        ).inMilliseconds, // ✅ convert to int
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add logging and caching interceptors
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );

    dio.interceptors.add(CacheInterceptorWrapper.getInterceptor());
  }
}

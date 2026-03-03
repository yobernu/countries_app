import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart' as dio_cache;

class CacheInterceptorWrapper {
  static dio_cache.DioCacheManager? _manager;

  static dio_cache.DioCacheManager get cacheManager {
    _manager ??= dio_cache.DioCacheManager(
      dio_cache.CacheConfig(baseUrl: 'https://restcountries.com/v3.1'),
    );
    return _manager!;
  }

  static Interceptor getInterceptor() {
    return cacheManager.interceptor;
  }

  /// Utility for building cache options for GET requests.
  static Options cacheOptions(
    Duration duration, {
    bool forceRefresh = false,
  }) {
    return dio_cache.buildCacheOptions(
      duration,
      forceRefresh: forceRefresh,
    );
  }
}


import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class CacheInterceptorWrapper {
  static DioCacheManager? _manager;

  static DioCacheManager get cacheManager {
    _manager ??= DioCacheManager(
      CacheConfig(baseUrl: "https://restcountries.com/v3.1"),
    );
    return _manager!;
  }

  static Interceptor getInterceptor() {
    return cacheManager.interceptor;
  }

  // Utility for building cache options
  static Options buildCacheOptions(
    Duration duration, {
    bool forceRefresh = false,
  }) {
    return buildCacheOptions(duration, forceRefresh: forceRefresh);
  }
}

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';

class CacheInterceptorWrapper {
  static CacheOptions? _baseOptions;

  /// Lazily build base cache options with a Hive-backed store.
  static Future<CacheOptions> _options() async {
    if (_baseOptions != null) return _baseOptions!;

    final dir = await getTemporaryDirectory();
    _baseOptions = CacheOptions(
      store: HiveCacheStore(dir.path),
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      priority: CachePriority.normal,
      maxStale: const Duration(days: 7),
    );
    return _baseOptions!;
  }

  /// Build and return a configured interceptor.
  static Future<Interceptor> getInterceptor() async {
    final opts = await _options();
    return DioCacheInterceptor(options: opts);
  }

  /// Utility for building cache options for GET requests.
  /// For simplicity we currently reuse the global options.
  static Future<Options> cacheOptions(
    Duration duration, {
    bool forceRefresh = false,
  }) async {
    final opts = await _options();
    return opts.toOptions();
  }
}
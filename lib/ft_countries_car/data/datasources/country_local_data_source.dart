import '../../../core/error/exceptions.dart';
import '../models/country_summary_model.dart';
import 'package:hive/hive.dart';

abstract class ICountryLocalDataSource {
  Future<List<CountrySummaryModel>> getFavorites();
  Future<void> toggleFavorite(CountrySummaryModel country);
  Future<bool> isFavorite(String cca2);

  /// Caches the list of countries used on the home screen.
  Future<void> cacheCountries(List<CountrySummaryModel> countries);
  /// Retrieves the cached list of countries; throws [CacheException] on failure.
  Future<List<CountrySummaryModel>> getCachedCountries();
  /// Searches the cached list of countries for the given query.
  Future<List<CountrySummaryModel>> searchCachedCountries(String query);
}

/// Hive‑backed implementation for both favorites and general country cache.
///
/// Two boxes are used:
///  * `favoritesBox` stores the user's favorite entries keyed by `cca2`.
///  * `cacheBox` holds the most recently downloaded list of countries (also
///    keyed by `cca2`) so that the app can show data when offline or when the
///    remote service is unavailable.
class CountryLocalDataSource implements ICountryLocalDataSource {
  final Box<CountrySummaryModel> favoritesBox;
  final Box<CountrySummaryModel> cacheBox;

  CountryLocalDataSource(
    this.favoritesBox,
    this.cacheBox,
  );

  @override
  Future<List<CountrySummaryModel>> getFavorites() async {
    try {
      return favoritesBox.values.toList();
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<void> toggleFavorite(CountrySummaryModel country) async {
    try {
      if (favoritesBox.containsKey(country.cca2)) {
        await favoritesBox.delete(country.cca2);
      } else {
        await favoritesBox.put(country.cca2, country);
      }
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<bool> isFavorite(String cca2) async {
    try {
      return favoritesBox.containsKey(cca2);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheCountries(List<CountrySummaryModel> countries) async {
    try {
      await cacheBox.clear();
      final entries = Map.fromEntries(
        countries.map((c) => MapEntry(c.cca2, c)),
      );
      await cacheBox.putAll(entries);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<List<CountrySummaryModel>> getCachedCountries() async {
    try {
      return cacheBox.values.toList();
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<List<CountrySummaryModel>> searchCachedCountries(String query) async {
    try {
      final all = cacheBox.values.toList();
      final lower = query.toLowerCase();
      return all.where((c) => c.name.toLowerCase().contains(lower)).toList();
    } catch (_) {
      throw CacheException();
    }
  }
}


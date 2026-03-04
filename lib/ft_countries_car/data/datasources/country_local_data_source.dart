import '../../../core/error/exceptions.dart';
import '../models/country_summary_model.dart';
import 'package:hive/hive.dart';

abstract class ICountryLocalDataSource {
  Future<List<String>> getFavorites();
  Future<void> toggleFavorite(String cca2);
  Future<bool> isFavorite(String cca2);
  Future<void> cacheCountryCapital(String cca2, String capital);
  Future<String?> getCachedCountryCapital(String cca2);

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
///  * `favoritesBox` stores the user's favorite country codes (`cca2`).
///  * `cacheBox` holds the most recently downloaded list of countries (also
///    keyed by `cca2`) so that the app can show data when offline or when the
///    remote service is unavailable.
///  * `capitalBox` stores capital strings keyed by `cca2` for offline favorites.
class CountryLocalDataSource implements ICountryLocalDataSource {
  final Box<String> favoritesBox;
  final Box<CountrySummaryModel> cacheBox;
  final Box<String> capitalBox;

  CountryLocalDataSource(
    this.favoritesBox,
    this.cacheBox,
    this.capitalBox,
  );

  @override
  Future<List<String>> getFavorites() async {
    try {
      return favoritesBox.keys.cast<String>().toList();
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<void> toggleFavorite(String cca2) async {
    try {
      if (favoritesBox.containsKey(cca2)) {
        await favoritesBox.delete(cca2);
      } else {
        await favoritesBox.put(cca2, cca2);
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
  Future<void> cacheCountryCapital(String cca2, String capital) async {
    try {
      await capitalBox.put(cca2, capital);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<String?> getCachedCountryCapital(String cca2) async {
    try {
      return capitalBox.get(cca2);
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


import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/exceptions.dart';
import '../models/country_summary_model.dart';

abstract class ICountryLocalDataSource {
  Future<List<CountrySummaryModel>> getFavorites();
  Future<void> toggleFavorite(CountrySummaryModel country);
  Future<bool> isFavorite(String cca2);
}

class CountryLocalDataSource implements ICountryLocalDataSource {
  static const _favoritesKey = 'favorite_countries';

  final SharedPreferences sharedPreferences;

  CountryLocalDataSource(this.sharedPreferences);

  @override
  Future<List<CountrySummaryModel>> getFavorites() async {
    try {
      final stored = sharedPreferences.getStringList(_favoritesKey) ?? [];
      return stored
          .map((e) =>
              CountrySummaryModel.fromJson(jsonDecode(e) as Map<String, dynamic>))
          .toList();
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<void> toggleFavorite(CountrySummaryModel country) async {
    try {
      final stored = sharedPreferences.getStringList(_favoritesKey) ?? [];

      final List<Map<String, dynamic>> decoded = stored
          .map((e) => jsonDecode(e) as Map<String, dynamic>)
          .toList();

      final existingIndex = decoded.indexWhere(
        (element) => element['cca2'] == country.cca2,
      );

      if (existingIndex >= 0) {
        decoded.removeAt(existingIndex);
      } else {
        decoded.add(country.toJson());
      }

      final encoded =
          decoded.map((e) => jsonEncode(e)).toList(growable: false);

      await sharedPreferences.setStringList(_favoritesKey, encoded);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<bool> isFavorite(String cca2) async {
    try {
      final stored = sharedPreferences.getStringList(_favoritesKey) ?? [];

      for (final item in stored) {
        final map = jsonDecode(item) as Map<String, dynamic>;
        if (map['cca2'] == cca2) {
          return true;
        }
      }

      return false;
    } catch (_) {
      throw CacheException();
    }
  }
}


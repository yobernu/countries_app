import '../../../core/error/exceptions.dart';
import '../../domain/entities/country_details.dart';
import '../../domain/entities/country_summary.dart';
import '../../domain/repositories/country_repository.dart';
import '../datasources/country_local_data_source.dart';
import '../datasources/country_remote_data_source.dart';

class CountryRepositoryImpl implements ICountryRepository {
  final ICountryRemoteDataSource remoteDataSource;
  final ICountryLocalDataSource localDataSource;

  CountryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<CountrySummary>> getAllCountries() async {
    try {
      final remoteList = await remoteDataSource.getAllCountries();
      // attempt to persist latest result for offline/home screen usage
      try {
        await localDataSource.cacheCountries(remoteList);
      } catch (_) {
        // ignore caching errors – remote result is still returned
      }
      return remoteList;
    } on ServerException {
      // fall back to cached value if available
      final cached = await localDataSource.getCachedCountries();
      if (cached.isNotEmpty) {
        return cached;
      }
      rethrow;
    }
  }

  @override
  Future<CountryDetails> getCountryDetails(String cca2) async {
    try {
      final details = await remoteDataSource.getCountryDetails(cca2);
      try {
        await localDataSource.cacheCountryCapital(cca2, details.capital);
      } catch (_) {
        // ignore local cache failures; detail response is still valid
      }
      return details;
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<CountrySummary>> searchCountries(String query) async {
    try {
      return await remoteDataSource.searchCountries(query);
    } on ServerException {
      // if remote fails, try searching locally
      return await localDataSource.searchCachedCountries(query);
    }
  }

  @override
  Future<List<CountryDetails>> getFavorites() async {
    try {
      final codes = await localDataSource.getFavorites();
      if (codes.isEmpty) return const [];

      final cachedByCode = {
        for (final c in await localDataSource.getCachedCountries()) c.cca2: c,
      };

      final results = await Future.wait(
        codes.map((code) async {
          try {
            final details = await remoteDataSource.getCountryDetails(code);
            try {
              await localDataSource.cacheCountryCapital(code, details.capital);
            } catch (_) {
              // ignore local cache failures; remote response is still valid
            }
            return details;
          } catch (_) {
            final cached = cachedByCode[code];
            if (cached == null) return null;
            String capital = '';
            try {
              capital = await localDataSource.getCachedCountryCapital(code) ?? '';
            } catch (_) {
              // ignore cache read failures and keep empty fallback
            }
            return CountryDetails(
              cca2: cached.cca2,
              name: cached.name,
              flag: cached.flag,
              population: cached.population,
              capital: capital,
              region: '',
              subregion: '',
              area: 0,
              timezones: const [],
            );
          }
        }),
      );

      return results.whereType<CountryDetails>().toList();
    } on CacheException {
      rethrow;
    }
  }

  @override
  Future<void> toggleFavorite(String cca2) async {
    try {
      await localDataSource.toggleFavorite(cca2);
    } on CacheException {
      rethrow;
    }
  }

  @override
  Future<bool> isFavorite(String cca2) async {
    try {
      return await localDataSource.isFavorite(cca2);
    } on CacheException {
      rethrow;
    }
  }
}


import '../../../core/error/exceptions.dart';
import '../../domain/entities/country_details.dart';
import '../../domain/entities/country_summary.dart';
import '../../domain/repositories/country_repository.dart';
import '../datasources/country_local_data_source.dart';
import '../datasources/country_remote_data_source.dart';
import '../models/country_summary_model.dart';

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
      return await remoteDataSource.getCountryDetails(cca2);
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
  Future<List<CountrySummary>> getFavorites() async {
    try {
      return await localDataSource.getFavorites();
    } on CacheException {
      rethrow;
    }
  }

  @override
  Future<void> toggleFavorite(CountrySummary country) async {
    try {
      final model = CountrySummaryModel(
        name: country.name,
        flag: country.flag,
        population: country.population,
        cca2: country.cca2,
        capital: country.capital,
      );
      await localDataSource.toggleFavorite(model);
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


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
      return await remoteDataSource.getAllCountries();
    } on ServerException {
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
      rethrow;
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


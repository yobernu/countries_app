import '../entities/country_details.dart';
import '../entities/country_summary.dart';

abstract class ICountryRepository {
  Future<List<CountrySummary>> getAllCountries();
  Future<List<CountrySummary>> searchCountries(String query);
  Future<CountryDetails> getCountryDetails(String cca2);
  Future<List<CountrySummary>> getFavorites();
  Future<void> toggleFavorite(CountrySummary country);
  Future<bool> isFavorite(String cca2);
}

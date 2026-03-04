import '../entities/country_details.dart';
import '../entities/country_summary.dart';

abstract class ICountryRepository {
  Future<List<CountrySummary>> getAllCountries();
  Future<List<CountrySummary>> searchCountries(String query);
  Future<CountryDetails> getCountryDetails(String cca2);
  Future<List<CountryDetails>> getFavorites();
  Future<void> toggleFavorite(String cca2);
  Future<bool> isFavorite(String cca2);
}

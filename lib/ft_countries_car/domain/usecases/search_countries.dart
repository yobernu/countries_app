import '../entities/country_summary.dart';
import '../repositories/country_repository.dart';

class SearchCountries {
  final ICountryRepository repository;

  SearchCountries(this.repository);

  Future<List<CountrySummary>> call(String query) async {
    return await repository.searchCountries(query);
  }
}

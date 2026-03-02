import '../entities/country_summary.dart';
import '../repositories/country_repository.dart';

class GetAllCountries {
  final ICountryRepository repository;

  GetAllCountries(this.repository);

  Future<List<CountrySummary>> call() async {
    return await repository.getAllCountries();
  }
}

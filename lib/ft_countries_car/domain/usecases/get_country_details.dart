import '../entities/country_details.dart';
import '../repositories/country_repository.dart';

class GetCountryDetails {
  final ICountryRepository repository;

  GetCountryDetails(this.repository);

  Future<CountryDetails> call(String cca2) async {
    return await repository.getCountryDetails(cca2);
  }
}

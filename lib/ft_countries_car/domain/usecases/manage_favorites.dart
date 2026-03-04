import '../entities/country_details.dart';
import '../repositories/country_repository.dart';

class ManageFavorites {
  final ICountryRepository repository;

  ManageFavorites(this.repository);

  Future<List<CountryDetails>> getFavorites() async {
    return await repository.getFavorites();
  }

  Future<void> toggleFavorite(String cca2) async {
    await repository.toggleFavorite(cca2);
  }

  Future<bool> isFavorite(String cca2) async {
    return await repository.isFavorite(cca2);
  }
}

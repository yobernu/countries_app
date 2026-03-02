import '../entities/country_summary.dart';
import '../repositories/country_repository.dart';

class ManageFavorites {
  final ICountryRepository repository;

  ManageFavorites(this.repository);

  Future<List<CountrySummary>> getFavorites() async {
    return await repository.getFavorites();
  }

  Future<void> toggleFavorite(CountrySummary country) async {
    await repository.toggleFavorite(country);
  }

  Future<bool> isFavorite(String cca2) async {
    return await repository.isFavorite(cca2);
  }
}

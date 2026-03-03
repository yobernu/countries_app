import 'package:flutter_test/flutter_test.dart';

import 'package:countries_app/ft_countries_car/domain/entities/country_details.dart';
import 'package:countries_app/ft_countries_car/domain/entities/country_summary.dart';
import 'package:countries_app/ft_countries_car/domain/repositories/country_repository.dart';
import 'package:countries_app/ft_countries_car/domain/usecases/get_all_countries.dart';

class _FakeCountryRepository implements ICountryRepository {
  final List<CountrySummary> allCountries;

  _FakeCountryRepository(this.allCountries);

  @override
  Future<List<CountrySummary>> getAllCountries() async => allCountries;

  @override
  Future<List<CountrySummary>> searchCountries(String query) async {
    return allCountries
        .where(
          (c) => c.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  @override
  Future<CountryDetails> getCountryDetails(String cca2) {
    throw UnimplementedError();
  }

  @override
  Future<List<CountrySummary>> getFavorites() {
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(CountrySummary country) {
    throw UnimplementedError();
  }

  @override
  Future<bool> isFavorite(String cca2) {
    throw UnimplementedError();
  }
}

void main() {
  group('GetAllCountries use case', () {
    test('returns list from repository', () async {
      final countries = [
        const CountrySummary(
          name: 'Ethiopia',
          flag: 'https://example.com/et.png',
          population: 100000000,
          cca2: 'ET',
        ),
      ];

      final repository = _FakeCountryRepository(countries);
      final usecase = GetAllCountries(repository);

      final result = await usecase();

      expect(result, equals(countries));
    });
  });
}


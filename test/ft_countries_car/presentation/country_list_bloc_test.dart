import 'package:bloc_test/bloc_test.dart';
import 'package:countries_app/ft_countries_car/domain/entities/country_summary.dart';
import 'package:countries_app/ft_countries_car/domain/usecases/get_all_countries.dart';
import 'package:countries_app/ft_countries_car/domain/usecases/search_countries.dart';
import 'package:countries_app/ft_countries_car/presentation/bloc/country_list/country_list_bloc.dart';
import 'package:countries_app/ft_countries_car/presentation/bloc/country_list/country_list_event.dart';
import 'package:countries_app/ft_countries_car/presentation/bloc/country_list/country_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetAllCountries extends Mock implements GetAllCountries {}

class _MockSearchCountries extends Mock implements SearchCountries {}

void main() {
  group('CountryListBloc', () {
    late _MockGetAllCountries mockGetAllCountries;
    late _MockSearchCountries mockSearchCountries;

    setUp(() {
      mockGetAllCountries = _MockGetAllCountries();
      mockSearchCountries = _MockSearchCountries();
    });

    blocTest<CountryListBloc, CountryListState>(
      'emits [loading, success] when LoadAllCountries succeeds',
      build: () {
        when(() => mockGetAllCountries())
            .thenAnswer((_) async => [
                  const CountrySummary(
                    name: 'Ethiopia',
                    flag: 'https://example.com/et.png',
                    population: 100000000,
                    cca2: 'ET',
                  ),
                ]);

        return CountryListBloc(
          getAllCountries: mockGetAllCountries,
          searchCountries: mockSearchCountries,
        );
      },
      act: (bloc) => bloc.add(const LoadAllCountries()),
      expect: () => [
        const CountryListState(status: CountryListStatus.loading),
        isA<CountryListState>()
            .having(
              (s) => s.status,
              'status',
              CountryListStatus.success,
            )
            .having((s) => s.countries.length, 'countries length', 1),
      ],
    );
  });
}


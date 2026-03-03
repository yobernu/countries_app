import 'package:countries_app/core/error/exceptions.dart';
import 'package:countries_app/ft_countries_car/data/datasources/country_local_data_source.dart';
import 'package:countries_app/ft_countries_car/data/datasources/country_remote_data_source.dart';
import 'package:countries_app/ft_countries_car/data/models/country_summary_model.dart';
import 'package:countries_app/ft_countries_car/data/repositories/country_repository_impl.dart';
import 'package:countries_app/ft_countries_car/domain/entities/country_summary.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRemoteDataSource extends Mock
    implements ICountryRemoteDataSource {}

class _MockLocalDataSource extends Mock implements ICountryLocalDataSource {}

void main() {
  group('CountryRepositoryImpl', () {
    late _MockRemoteDataSource mockRemote;
    late _MockLocalDataSource mockLocal;
    late CountryRepositoryImpl repository;

    setUp(() {
      mockRemote = _MockRemoteDataSource();
      mockLocal = _MockLocalDataSource();
      repository = CountryRepositoryImpl(
        remoteDataSource: mockRemote,
        localDataSource: mockLocal,
      );
    });

    test('getAllCountries delegates to remote data source', () async {
      final models = [
        const CountrySummaryModel(
          name: 'Ethiopia',
          flag: 'https://example.com/et.png',
          population: 100000000,
          cca2: 'ET',
        ),
      ];

      when(() => mockRemote.getAllCountries())
          .thenAnswer((_) async => models);

      final result = await repository.getAllCountries();

      expect(result, isA<List<CountrySummary>>());
      expect(result.length, 1);
      expect(result.first.name, 'Ethiopia');
      expect(result.first.cca2, 'ET');
      verify(() => mockRemote.getAllCountries()).called(1);
      verifyNoMoreInteractions(mockRemote);
    });

    test('getAllCountries rethrows ServerException from remote', () async {
      when(() => mockRemote.getAllCountries()).thenThrow(ServerException());

      expect(
        () => repository.getAllCountries(),
        throwsA(isA<ServerException>()),
      );
    });
  });
}


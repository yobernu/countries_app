import 'package:countries_app/core/network/api_endpoints.dart';
import 'package:countries_app/core/network/dio_client.dart';
import 'package:countries_app/ft_countries_car/data/datasources/country_remote_data_source.dart';
import 'package:countries_app/ft_countries_car/data/models/country_summary_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDio extends Mock implements Dio {}

void main() {
  group('CountryRemoteDataSource', () {
    late _MockDio mockDio;
    late CountryRemoteDataSource dataSource;

    setUp(() {
      mockDio = _MockDio();
      final client = DioClient(
        dio: mockDio,
        enableCache: false,
        enableLogging: false,
      );
      dataSource = CountryRemoteDataSource(client);
    });

    test('getAllCountries parses list of CountrySummaryModel', () async {
      when(
        () => mockDio.get(
          ApiEndpoints.allCountries,
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: [
            {
              'name': {'common': 'Ethiopia'},
              'flags': {'png': 'https://example.com/et.png'},
              'population': 100000000,
              'cca2': 'ET',
            },
          ],
          statusCode: 200,
          requestOptions: RequestOptions(path: ApiEndpoints.allCountries),
        ),
      );

      final result = await dataSource.getAllCountries();

      expect(result, isA<List<CountrySummaryModel>>());
      expect(result.first.name, 'Ethiopia');
      expect(result.first.cca2, 'ET');
    });
  });
}


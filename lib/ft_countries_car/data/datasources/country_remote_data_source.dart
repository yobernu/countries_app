import 'package:dio/dio.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../models/country_details_model.dart';
import '../models/country_summary_model.dart';

abstract class ICountryRemoteDataSource {
  Future<List<CountrySummaryModel>> getAllCountries();
  Future<List<CountrySummaryModel>> searchCountries(String query);
  Future<CountryDetailsModel> getCountryDetails(String cca2);
}

class CountryRemoteDataSource implements ICountryRemoteDataSource {
  final DioClient client;

  CountryRemoteDataSource(this.client);

  Dio get _dio => client.dio;

  @override
  Future<List<CountrySummaryModel>> getAllCountries() async {
    try {
      final response = await _dio.get(
        ApiEndpoints.allCountries,
        queryParameters: {
          'fields': ApiEndpoints.summaryFields,
        },
      );

      if (response.data is! List) {
        throw ServerException();
      }

      final list = response.data as List;
      return list
          .map((e) =>
              CountrySummaryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioError {
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<CountrySummaryModel>> searchCountries(String query) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.searchCountries(query),
        queryParameters: {
          'fields': ApiEndpoints.summaryFields,
        },
      );

      if (response.data is! List) {
        throw ServerException();
      }

      final list = response.data as List;
      return list
          .map((e) =>
              CountrySummaryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioError {
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<CountryDetailsModel> getCountryDetails(String cca2) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.getCountryDetails(cca2),
        queryParameters: {
          'fields': ApiEndpoints.detailFields,
        },
      );

      // REST Countries alpha endpoint returns a list with one item.
      if (response.data is List && (response.data as List).isNotEmpty) {
        final map = (response.data as List).first as Map<String, dynamic>;
        return CountryDetailsModel.fromJson(map, fallbackCca2: cca2);
      }

      if (response.data is Map<String, dynamic>) {
        return CountryDetailsModel.fromJson(
          response.data as Map<String, dynamic>,
          fallbackCca2: cca2,
        );
      }

      throw ServerException();
    } on DioError {
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }
}

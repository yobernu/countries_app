import '../../domain/entities/country_details.dart';

class CountryDetailsModel extends CountryDetails {
  const CountryDetailsModel({
    required super.cca2,
    required super.name,
    required super.flag,
    required super.population,
    required super.capital,
    required super.region,
    required super.subregion,
    required super.area,
    required super.timezones,
  });

  factory CountryDetailsModel.fromJson(
    Map<String, dynamic> json, {
    String? fallbackCca2,
  }) {
    final cca2 = (json['cca2'] as String?) ?? fallbackCca2 ?? '';
    final name = (json['name']?['common'] as String?) ?? '';
    final flags = json['flags'] as Map<String, dynamic>?;

    final flag = (flags?['png'] as String?) ??
        (flags?['svg'] as String?) ??
        '';

    final population = (json['population'] is int)
        ? json['population'] as int
        : (json['population'] is num)
            ? (json['population'] as num).toInt()
            : 0;

    final capitals = (json['capital'] as List?)?.cast<String>() ?? const [];
    final capital = capitals.isNotEmpty ? capitals.first : '';

    final region = (json['region'] as String?) ?? '';
    final subregion = (json['subregion'] as String?) ?? '';

    final area = (json['area'] is double)
        ? json['area'] as double
        : (json['area'] is num)
            ? (json['area'] as num).toDouble()
            : 0.0;

    final timezones =
        (json['timezones'] as List?)?.map((e) => e.toString()).toList() ??
            const <String>[];

    return CountryDetailsModel(
      cca2: cca2,
      name: name,
      flag: flag,
      population: population,
      capital: capital,
      region: region,
      subregion: subregion,
      area: area,
      timezones: timezones,
    );
  }
}


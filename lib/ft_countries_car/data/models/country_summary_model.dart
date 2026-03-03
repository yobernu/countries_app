import '../../domain/entities/country_summary.dart';

class CountrySummaryModel extends CountrySummary {
  const CountrySummaryModel({
    required super.name,
    required super.flag,
    required super.population,
    required super.cca2,
  });

  factory CountrySummaryModel.fromJson(Map<String, dynamic> json) {
    final name = (json['name']?['common'] as String?) ?? '';
    final flags = json['flags'] as Map<String, dynamic>?;

    // Prefer PNG flag, fall back to SVG if needed.
    final flag = (flags?['png'] as String?) ??
        (flags?['svg'] as String?) ??
        '';

    final population = (json['population'] is int)
        ? json['population'] as int
        : (json['population'] is num)
            ? (json['population'] as num).toInt()
            : 0;

    final cca2 = (json['cca2'] as String?) ?? '';

    return CountrySummaryModel(
      name: name,
      flag: flag,
      population: population,
      cca2: cca2,
    );
  }

  /// Used for local persistence (favorites).
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'flag': flag,
      'population': population,
      'cca2': cca2,
    };
  }
}


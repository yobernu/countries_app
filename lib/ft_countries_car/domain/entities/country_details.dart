import 'package:equatable/equatable.dart';

class CountryDetails extends Equatable {
  final String cca2;
  final String name;
  final String flag;
  final int population;
  final String capital;
  final String region;
  final String subregion;
  final double area;
  final List<String> timezones;

  const CountryDetails({
    required this.cca2,
    required this.name,
    required this.flag,
    required this.population,
    required this.capital,
    required this.region,
    required this.subregion,
    required this.area,
    required this.timezones,
  });

  @override
  List<Object?> get props => [
    cca2,
    name,
    flag,
    population,
    capital,
    region,
    subregion,
    area,
    timezones,
  ];
}

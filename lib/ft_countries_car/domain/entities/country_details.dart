import 'package:equatable/equatable.dart';

class CountryDetails extends Equatable {
  final String name;
  final String flag;
  final int population;
  final String capital;
  final String region;
  final String subregion;
  final double area;
  final List<String> timezones;

  const CountryDetails({
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

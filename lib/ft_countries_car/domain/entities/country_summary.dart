import 'package:equatable/equatable.dart';

class CountrySummary extends Equatable {
  final String name;
  final String flag;
  final int population;
  final String cca2;
  final List<String> capital; // newly stored capital, may be empty if unknown

  const CountrySummary({
    required this.name,
    required this.flag,
    required this.population,
    required this.cca2,
    required this.capital,
  });

  @override
  List<Object?> get props => [name, flag, population, cca2, capital];
}

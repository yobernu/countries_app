import 'package:equatable/equatable.dart';

class CountrySummary extends Equatable {
  final String name;
  final String flag;
  final int population;
  final String cca2;

  const CountrySummary({
    required this.name,
    required this.flag,
    required this.population,
    required this.cca2,
  });

  @override
  List<Object?> get props => [name, flag, population, cca2];
}

import 'package:equatable/equatable.dart';

abstract class CountryDetailsEvent extends Equatable {
  const CountryDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadCountryDetails extends CountryDetailsEvent {
  final String cca2;

  const LoadCountryDetails(this.cca2);

  @override
  List<Object?> get props => [cca2];
}


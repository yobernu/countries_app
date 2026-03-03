import 'package:equatable/equatable.dart';

abstract class CountryListEvent extends Equatable {
  const CountryListEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllCountries extends CountryListEvent {
  const LoadAllCountries();
}

class SearchCountriesEvent extends CountryListEvent {
  final String query;

  const SearchCountriesEvent(this.query);

  @override
  List<Object?> get props => [query];
}


import 'package:equatable/equatable.dart';

import '../../../domain/entities/country_summary.dart';

enum CountryListStatus { initial, loading, success, empty, error }

class CountryListState extends Equatable {
  final CountryListStatus status;
  final List<CountrySummary> countries;
  final String message;

  const CountryListState({
    this.status = CountryListStatus.initial,
    this.countries = const [],
    this.message = '',
  });

  CountryListState copyWith({
    CountryListStatus? status,
    List<CountrySummary>? countries,
    String? message,
  }) {
    return CountryListState(
      status: status ?? this.status,
      countries: countries ?? this.countries,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, countries, message];
}


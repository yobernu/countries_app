import 'package:equatable/equatable.dart';

import '../../../domain/entities/country_details.dart';

enum CountryDetailsStatus { initial, loading, success, error }

class CountryDetailsState extends Equatable {
  final CountryDetailsStatus status;
  final CountryDetails? country;
  final String message;

  const CountryDetailsState({
    this.status = CountryDetailsStatus.initial,
    this.country,
    this.message = '',
  });

  CountryDetailsState copyWith({
    CountryDetailsStatus? status,
    CountryDetails? country,
    String? message,
  }) {
    return CountryDetailsState(
      status: status ?? this.status,
      country: country ?? this.country,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, country, message];
}


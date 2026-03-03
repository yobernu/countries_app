import 'package:equatable/equatable.dart';

import '../../../domain/entities/country_summary.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {
  const LoadFavorites();
}

class ToggleFavoriteEvent extends FavoritesEvent {
  final CountrySummary country;

  const ToggleFavoriteEvent(this.country);

  @override
  List<Object?> get props => [country];
}


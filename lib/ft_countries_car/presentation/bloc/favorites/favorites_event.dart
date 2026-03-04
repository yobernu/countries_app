import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {
  const LoadFavorites();
}

class ToggleFavoriteEvent extends FavoritesEvent {
  final String cca2;

  const ToggleFavoriteEvent(this.cca2);

  @override
  List<Object?> get props => [cca2];
}


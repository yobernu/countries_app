import 'package:equatable/equatable.dart';

abstract class FavoritesStatusEvent extends Equatable {
  const FavoritesStatusEvent();

  @override
  List<Object?> get props => [];
}

class CheckFavoriteStatus extends FavoritesStatusEvent {
  final String cca2;

  const CheckFavoriteStatus(this.cca2);

  @override
  List<Object?> get props => [cca2];
}

class RefreshFavoriteStatus extends FavoritesStatusEvent {
  final String cca2;

  const RefreshFavoriteStatus(this.cca2);

  @override
  List<Object?> get props => [cca2];
}


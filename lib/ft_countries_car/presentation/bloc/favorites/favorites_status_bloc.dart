import 'package:bloc/bloc.dart';

import '../../../domain/usecases/manage_favorites.dart';
import 'favorites_status_event.dart';

class FavoritesStatusBloc extends Bloc<FavoritesStatusEvent, bool> {
  final ManageFavorites manageFavorites;

  FavoritesStatusBloc(this.manageFavorites) : super(false) {
    on<CheckFavoriteStatus>(_onCheckFavoriteStatus);
    on<RefreshFavoriteStatus>(_onRefreshFavoriteStatus);
  }

  Future<void> _onCheckFavoriteStatus(
    CheckFavoriteStatus event,
    Emitter<bool> emit,
  ) async {
    try {
      final isFav = await manageFavorites.isFavorite(event.cca2);
      emit(isFav);
    } catch (_) {
      // On error, keep current state; UI may choose to ignore.
    }
  }

  Future<void> _onRefreshFavoriteStatus(
    RefreshFavoriteStatus event,
    Emitter<bool> emit,
  ) async {
    // Currently behaves the same as CheckFavoriteStatus,
    // but kept as a distinct event to allow future differentiation.
    await _onCheckFavoriteStatus(
      CheckFavoriteStatus(event.cca2),
      emit,
    );
  }
}


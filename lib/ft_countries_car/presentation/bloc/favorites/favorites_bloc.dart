import 'package:bloc/bloc.dart';

import '../../../domain/entities/country_details.dart';
import '../../../domain/usecases/manage_favorites.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final ManageFavorites manageFavorites;

  FavoritesBloc(this.manageFavorites) : super(const FavoritesState()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(status: FavoritesStatus.loading, message: ''));

    try {
      final List<CountryDetails> result =
          await manageFavorites.getFavorites();

      if (result.isEmpty) {
        emit(
          state.copyWith(
            status: FavoritesStatus.empty,
            favorites: const [],
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: FavoritesStatus.success,
            favorites: result,
          ),
        );
      }
    } catch (_) {
      emit(
        state.copyWith(
          status: FavoritesStatus.error,
          message: 'Failed to load favorites.',
        ),
      );
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await manageFavorites.toggleFavorite(event.cca2);
      // Refresh favorites after toggle
      add(const LoadFavorites());
    } catch (_) {
      emit(
        state.copyWith(
          status: FavoritesStatus.error,
          message: 'Failed to update favorites.',
        ),
      );
    }
  }
}


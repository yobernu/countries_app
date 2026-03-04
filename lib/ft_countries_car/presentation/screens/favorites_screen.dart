import 'dart:async';
import 'package:countries_app/core/theme/app_colors.dart';
import 'package:countries_app/ft_countries_car/presentation/bloc/favorites/favorites_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:countries_app/ft_countries_car/presentation/widgets/favorites_card.dart';
import '../screens/details_screen.dart';

import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_state.dart';

/// Displays the user's favorited countries and allows unfavoriting directly.
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  Future<void> _onRefresh() {
    final bloc = context.read<FavoritesBloc>();
    final completer = Completer<void>();
    late final StreamSubscription<FavoritesState> sub;
    sub = bloc.stream.listen((state) {
      if (state.status != FavoritesStatus.loading) {
        completer.complete();
        sub.cancel();
      }
    });
    bloc.add(const LoadFavorites());
    return completer.future;
  }

  Widget _scrollableWrapper(Widget child) {
    if (child is ScrollView) return child;
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites',
            style: TextStyle(
              color: AppColors.getTextPrimary(context),
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.status == FavoritesStatus.initial) {
            context.read<FavoritesBloc>().add(const LoadFavorites());
          }

          Widget body;
          switch (state.status) {
            case FavoritesStatus.loading:
              body = const Center(child: CircularProgressIndicator());
              break;
            case FavoritesStatus.empty:
              body = const Center(child: Text('No favorites yet.'));
              break;
            case FavoritesStatus.error:
              body = Center(child: Text(state.message));
              break;
            case FavoritesStatus.success:
              body = ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                itemCount: state.favorites.length,
                itemBuilder: (context, index) {
                  final country = state.favorites[index];
                  return FavoritesCard(
                    country: country,
                    onToggleFavorite: () {
                      context
                          .read<FavoritesBloc>()
                          .add(ToggleFavoriteEvent(country.cca2));
                    },
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DetailsScreen(
                              cca2: country.cca2, countryName: country.name)),
                    ),
                  );
                },
              );
              break;
            case FavoritesStatus.initial:
              body = const SizedBox.shrink();
              break;
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: AppColors.primary,
            backgroundColor: AppColors.getSurface(context),
            edgeOffset: 16,
            strokeWidth: 3.0,
            displacement: 40,
            child: _scrollableWrapper(body),
          );
        },
      ),
    );
  }
}

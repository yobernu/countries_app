import 'package:countries_app/ft_countries_car/presentation/widgets/search_result_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/country_summary.dart';
import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_event.dart';
import '../bloc/favorites/favorites_state.dart';
import 'country_card.dart';


class CountriesList extends StatelessWidget {
  final List<CountrySummary> countries;
  final void Function(CountrySummary country)? onCountryTap;
  final bool useSearchCard;

  const CountriesList({
    super.key,
    required this.countries,
    this.onCountryTap,
    this.useSearchCard = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, favState) {
        final favCca2 = favState.favorites.map((e) => e.cca2).toSet();

        // Using CustomScrollView for maximum flexibility and zero overflow
        return CustomScrollView(
          // Allows the list to shrink-wrap its content if needed
          shrinkWrap: false, 
          // Ensures physics work correctly across all platforms
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final country = countries[index];
                    final isFav = favCca2.contains(country.cca2);

                    // Wrap in a Column to replicate the "separated" divider effect
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (useSearchCard)
                          SearchResultCard(
                            country: country,
                            onTap: onCountryTap == null ? null : () => onCountryTap!(country),
                          )
                        else
                          CountriesCard(
                            country: country,
                            isFavorite: isFav,
                            onToggleFavorite: () => context
                                .read<FavoritesBloc>()
                                .add(ToggleFavoriteEvent(country.cca2)),
                            onTap: onCountryTap == null 
                                ? null 
                                : () => onCountryTap!(country),
                          ),
                      ],
                    );
                  },
                  childCount: countries.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

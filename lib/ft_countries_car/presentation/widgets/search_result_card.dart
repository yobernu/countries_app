import 'package:flutter/material.dart';

import 'package:countries_app/core/theme/app_colors.dart';
import 'package:countries_app/core/theme/app_text_styles.dart';
import 'package:countries_app/ft_countries_car/domain/entities/country_summary.dart';

class SearchResultCard extends StatelessWidget {
  final CountrySummary country;
  final VoidCallback? onTap;

  const SearchResultCard({super.key, required this.country, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // ensure the card fills the available width so items align vertically
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          // expand the Row to use the full width provided by the parent
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Hero(
              tag: country.cca2,
              child: Container(
                  width: 85,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    image: DecorationImage(
                        image: NetworkImage(country.flag),
                        fit: BoxFit.fitWidth),
                  ),
                  child: Stack(children: <Widget>[
            
          ])),
            ),
            const SizedBox(width: 16),
            Container(
              decoration: const BoxDecoration(),
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    country.name,
                    textAlign: TextAlign.left,
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
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
                    fit: BoxFit.fitWidth,
                  ),
                ),
                // Removed the empty Stack for cleaner code
              ),
            ),
            const SizedBox(width: 16),
            // --- FIX START ---
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start, // Keeps text left-aligned
                children: <Widget>[
                  Text(
                    country.name,
                    textAlign: TextAlign.left,
                    style: AppTextStyles.title.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    softWrap: true, // Allows the text to wrap to the next line
                    overflow: TextOverflow.visible, // Or use TextOverflow.ellipsis for "..."
                  ),
                ],
              ),
            ),
            // --- FIX END ---
          ],
        ),
      ),
    );
  }
}
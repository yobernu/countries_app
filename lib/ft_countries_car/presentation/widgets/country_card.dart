import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:countries_app/core/theme/app_colors.dart';
import 'package:countries_app/core/theme/app_text_styles.dart';

import '../../../core/utils/formatters.dart';
import '../../domain/entities/country_summary.dart';

class CountriesCard extends StatelessWidget {
  final CountrySummary country;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback? onTap;

  const CountriesCard({
    super.key,
    required this.country,
    required this.isFavorite,
    required this.onToggleFavorite,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Hero(
              tag: country.cca2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: country.flag,
                  width: 100,
                  height: 56,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    width: 100,
                    height: 56,
                    color: AppColors.getBackgroundLight(context),
                  ),
                  errorWidget: (_, __, ___) => Container(
                    width: 100,
                    height: 56,
                    color: AppColors.getBackgroundLight(context),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.name,
                    style: AppTextStyles.title.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Population: ${formatPopulation(country.population)}',
                    style: AppTextStyles.body.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onToggleFavorite,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite
                    ? AppColors.favorite
                    : Theme.of(context).iconTheme.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

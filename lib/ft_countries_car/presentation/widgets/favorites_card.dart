import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:countries_app/core/theme/app_colors.dart';
import 'package:countries_app/core/theme/app_text_styles.dart';
import '../../domain/entities/country_summary.dart';

class FavoritesCard extends StatelessWidget {
  final CountrySummary country;
  final VoidCallback onToggleFavorite;
  final VoidCallback? onTap;

  const FavoritesCard({
    super.key,
    required this.country,
    required this.onToggleFavorite,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: country.flag,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  width: 56,
                  height: 56,
                  color: AppColors.getBackgroundLight(context),
                ),
                errorWidget: (_, __, ___) => Container(
                  width: 56,
                  height: 56,
                  color: AppColors.getBackgroundLight(context),
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
                  if (country.capital.isNotEmpty)
                    Text(
                      'Capital: ${country.capital.first}',
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
                Icons.favorite,
                color: AppColors.favorite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

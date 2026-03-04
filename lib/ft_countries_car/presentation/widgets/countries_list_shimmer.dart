import 'package:countries_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListShimmer extends StatelessWidget {
  final int itemCount;

  const CountriesListShimmer({super.key, this.itemCount = 10});

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context);
    final baseColor = base.colorScheme.onSurface.withOpacity(0.08);
    final highlight = base.colorScheme.surface;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlight,
      child: ListView.separated(
        itemCount: itemCount,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 14, width: 140, color: Theme.of(context).colorScheme.surface),
                      const SizedBox(height: 8),
                      Container(height: 12, width: 180, color: Theme.of(context).colorScheme.surface),
                    ],
                  ),
                ),
                const SizedBox(width: 40, height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}


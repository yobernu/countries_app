import 'package:flutter/material.dart';

import 'package:countries_app/core/theme/app_colors.dart';
import 'package:countries_app/core/theme/app_text_styles.dart';

class KeyStats extends StatelessWidget {
  final String label;
  final String value;

  const KeyStats({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.getTextSecondary(context),
          fontSize: 14,
          height: 1.5,
        );

    final valueStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.getTextPrimary(context),
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.5,
        );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: labelStyle ?? AppTextStyles.subtitle),
          const SizedBox(width: 24),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: valueStyle ??
                  AppTextStyles.title.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

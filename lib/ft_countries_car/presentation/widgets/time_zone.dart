import 'package:countries_app/core/utils/formatters.dart';
import 'package:flutter/material.dart';

import 'package:countries_app/core/theme/app_colors.dart';
import 'package:countries_app/core/theme/app_text_styles.dart';

class TimeZone extends StatelessWidget {
  final String timezone;

  const TimeZone({
    super.key,
    required this.timezone,
  });

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator TimeZone - FRAME - HORIZONTAL
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.white,
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(),
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  
                  timeZoneFormat(timezone),
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                        height: 1.25,
                      ) ??
                      AppTextStyles.title.copyWith(color: AppColors.textPrimary, height: 1.25),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

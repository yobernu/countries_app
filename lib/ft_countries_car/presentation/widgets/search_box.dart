import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'package:countries_app/core/theme/app_colors.dart';
import 'package:countries_app/core/theme/app_text_styles.dart';

class SearchBox extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchBox({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Search for a country',
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        final hasText = value.text.isNotEmpty;

        return TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                ),
            prefixIcon: Icon(
              Symbols.search,
              color: AppColors.textHint,
            ),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 30, // Minimum space the suffix area takes
              minHeight: 30,
            ),
            // show a circular 'x' when there's text; clear on tap
            suffixIcon: hasText
                ? Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        controller.clear();
                        onChanged('');
                      },
                      child: Image.asset(
                        'assets/images/close_icon.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  )
                : null,
            filled: true,
            // allow theme to provide fillColor
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        );
      },
    );
  }
}

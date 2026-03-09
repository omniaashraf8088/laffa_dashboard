import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// A horizontal scrollable row of filter chips.
class FilterChipBar extends StatelessWidget {
  final List<String> filters;
  final String selected;
  final ValueChanged<String> onSelected;

  const FilterChipBar({
    super.key,
    required this.filters,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isActive = selected == filter;
          return FilterChip(
            label: Text(filter),
            selected: isActive,
            onSelected: (_) => onSelected(filter),
            selectedColor: AppColors.purple,
            checkmarkColor: Colors.white,
            backgroundColor: AppColors.surface,
            labelStyle: TextStyle(
              color: isActive ? Colors.white : AppColors.textMuted,
              fontSize: 13,
            ),
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }
}

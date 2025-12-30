import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../domain/entities/niyet_category.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final NiyetCategory selected;
  final ValueChanged<NiyetCategory> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: NiyetCategory.values.map((category) {
        final isSelected = category == selected;
        return _CategoryChip(
          category: category,
          isSelected: isSelected,
          onTap: () => onSelected(category),
        );
      }).toList(),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final NiyetCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  Color get _color {
    switch (category) {
      case NiyetCategory.ibadah:
        return AppColors.ibadah;
      case NiyetCategory.akhlaq:
        return AppColors.akhlaq;
      case NiyetCategory.family:
        return AppColors.family;
      case NiyetCategory.charity:
        return AppColors.charity;
      case NiyetCategory.work:
        return AppColors.work;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? _color : _color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? _color : _color.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          category.label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: isSelected ? Colors.white : _color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
        ),
      ),
    );
  }
}

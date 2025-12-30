import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../domain/entities/niyet_outcome.dart';

class OutcomeSelector extends StatelessWidget {
  const OutcomeSelector({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final NiyetOutcome? selected;
  final ValueChanged<NiyetOutcome> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: NiyetOutcome.values.map((outcome) {
        final isSelected = outcome == selected;
        return _OutcomeButton(
          outcome: outcome,
          isSelected: isSelected,
          onTap: () => onSelected(outcome),
        );
      }).toList(),
    );
  }
}

class _OutcomeButton extends StatelessWidget {
  const _OutcomeButton({
    required this.outcome,
    required this.isSelected,
    required this.onTap,
  });

  final NiyetOutcome outcome;
  final bool isSelected;
  final VoidCallback onTap;

  Color get _color {
    switch (outcome) {
      case NiyetOutcome.fulfilled:
        return AppColors.fulfilled;
      case NiyetOutcome.tried:
        return AppColors.tried;
      case NiyetOutcome.missed:
        return AppColors.missed;
    }
  }

  IconData get _icon {
    switch (outcome) {
      case NiyetOutcome.fulfilled:
        return Icons.check_circle_outline;
      case NiyetOutcome.tried:
        return Icons.trending_up;
      case NiyetOutcome.missed:
        return Icons.remove_circle_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? _color : _color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? _color : _color.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _icon,
              color: isSelected ? Colors.white : _color,
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              outcome.label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: isSelected ? Colors.white : _color,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class CalendarDayCell extends StatelessWidget {
  const CalendarDayCell({
    required this.date,
    required this.isCurrentMonth,
    required this.isToday,
    required this.hasNiyetler,
    required this.allReflected,
    required this.onTap,
    super.key,
  });

  final DateTime date;
  final bool isCurrentMonth;
  final bool isToday;
  final bool hasNiyetler;
  final bool allReflected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Day number text style
    final textStyle = theme.textTheme.bodyMedium?.copyWith(
      color: isCurrentMonth
          ? null
          : theme.colorScheme.onSurface.withValues(alpha: 0.3),
      fontWeight: isToday ? FontWeight.bold : null,
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: isToday
            ? BoxDecoration(
                border: Border.all(
                  color: AppColors.primary,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(date.day.toString(), style: textStyle),
            const SizedBox(height: 4),
            // Indicator dot
            if (hasNiyetler)
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: allReflected
                      ? AppColors.primary // #6B8E6B (full sage)
                      : AppColors.primaryLight, // #8FB08F (light sage)
                ),
              )
            else
              const SizedBox(height: 6), // Placeholder for alignment
          ],
        ),
      ),
    );
  }
}

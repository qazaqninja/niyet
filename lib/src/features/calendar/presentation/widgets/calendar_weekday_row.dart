import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarWeekdayRow extends StatelessWidget {
  const CalendarWeekdayRow({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;

    // Get localized weekday names (abbreviated)
    final symbols = DateFormat.E(locale).dateSymbols;
    final weekdays = symbols.STANDALONESHORTWEEKDAYS;

    // Reorder so Monday is first (weekdays[0] is Sunday by default)
    final orderedWeekdays = [...weekdays.sublist(1), weekdays[0]];

    return Row(
      children: orderedWeekdays
          .map((day) => Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}

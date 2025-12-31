import 'package:flutter/material.dart';

import '../bloc/calendar_bloc.dart';
import 'calendar_day_cell.dart';

class CalendarGrid extends StatelessWidget {
  const CalendarGrid({
    required this.focusedMonth,
    required this.state,
    required this.onDayTap,
    super.key,
  });

  final DateTime focusedMonth;
  final CalendarState state;
  final void Function(DateTime) onDayTap;

  List<DateTime> _generateDaysForMonth() {
    final firstOfMonth = DateTime(focusedMonth.year, focusedMonth.month, 1);

    // Get the weekday of first day (1=Mon, 7=Sun)
    // We want Monday to be index 0
    final firstWeekday = firstOfMonth.weekday; // 1-7 (Mon-Sun)
    final leadingDays = firstWeekday - 1; // Days from prev month

    // Start from the Monday before the first of month
    final startDate = firstOfMonth.subtract(Duration(days: leadingDays));

    // Generate 6 weeks (42 days) for consistent grid
    return List.generate(42, (i) => startDate.add(Duration(days: i)));
  }

  @override
  Widget build(BuildContext context) {
    final days = _generateDaysForMonth();
    final today = DateTime.now();

    return Align(
      alignment: Alignment.topCenter,
      child: AspectRatio(
        aspectRatio: 7 / 6, // 7 columns, 6 rows
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
          ),
          itemCount: days.length,
          itemBuilder: (context, index) {
            final day = days[index];
            final isCurrentMonth = day.month == focusedMonth.month;
            final isToday = day.year == today.year &&
                day.month == today.month &&
                day.day == today.day;

            return CalendarDayCell(
              date: day,
              isCurrentMonth: isCurrentMonth,
              isToday: isToday,
              hasNiyetler: state.hasNiyetler(day),
              allReflected: state.allReflected(day),
              onTap: () => onDayTap(day),
            );
          },
        ),
      ),
    );
  }
}

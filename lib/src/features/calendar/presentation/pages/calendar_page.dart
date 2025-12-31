import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../../core/services/injectable/injectable_service.dart';
import '../../../niyet/presentation/bloc/niyet_bloc.dart';
import '../bloc/calendar_bloc.dart';
import '../widgets/calendar_grid.dart';
import '../widgets/calendar_header.dart';
import '../widgets/calendar_weekday_row.dart';
import '../widgets/day_niyetler_bottom_sheet.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CalendarBloc>()..add(const CalendarMonthLoaded()),
      child: const _CalendarView(),
    );
  }
}

class _CalendarView extends StatefulWidget {
  const _CalendarView();

  @override
  State<_CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<_CalendarView> {
  late PageController _pageController;

  // Use a large initial page to allow scrolling in both directions
  static const int _initialPage = 1200; // ~100 years in each direction

  DateTime _getMonthFromPage(int page, DateTime baseMonth) {
    final offset = page - _initialPage;
    return DateTime(baseMonth.year, baseMonth.month + offset, 1);
  }

  int _getPageFromMonth(DateTime month, DateTime baseMonth) {
    final yearDiff = month.year - baseMonth.year;
    final monthDiff = month.month - baseMonth.month;
    return _initialPage + (yearDiff * 12) + monthDiff;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page, DateTime baseMonth) {
    final newMonth = _getMonthFromPage(page, baseMonth);
    context.read<CalendarBloc>().add(CalendarMonthChanged(newMonth));
  }

  void _goToPreviousMonth(DateTime baseMonth, DateTime focusedMonth) {
    final targetPage = _getPageFromMonth(
      DateTime(focusedMonth.year, focusedMonth.month - 1, 1),
      baseMonth,
    );
    _pageController.animateToPage(
      targetPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToNextMonth(DateTime baseMonth, DateTime focusedMonth) {
    final targetPage = _getPageFromMonth(
      DateTime(focusedMonth.year, focusedMonth.month + 1, 1),
      baseMonth,
    );
    _pageController.animateToPage(
      targetPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Base month is the month when the widget was first built
    final baseMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.calendar),
        centerTitle: false,
      ),
      body: BlocConsumer<CalendarBloc, CalendarState>(
        listenWhen: (previous, current) =>
            previous.selectedDate != current.selectedDate &&
            current.selectedDate != null,
        listener: (context, state) {
          _showDayBottomSheet(context, state);
        },
        builder: (context, state) {
          return Column(
            children: [
              // Month navigation header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: CalendarHeader(
                  focusedMonth: state.focusedMonth,
                  onPreviousMonth: () => _goToPreviousMonth(baseMonth, state.focusedMonth),
                  onNextMonth: () => _goToNextMonth(baseMonth, state.focusedMonth),
                ),
              ),
              // Weekday labels
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: CalendarWeekdayRow(),
              ),
              const SizedBox(height: 8),
              // Swipeable calendar grid
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (page) => _onPageChanged(page, baseMonth),
                  itemBuilder: (context, page) {
                    final monthForPage = _getMonthFromPage(page, baseMonth);

                    // Show loading only for the focused month
                    if (state.isLoading &&
                        monthForPage.year == state.focusedMonth.year &&
                        monthForPage.month == state.focusedMonth.month) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CalendarGrid(
                        focusedMonth: monthForPage,
                        state: state,
                        onDayTap: (date) {
                          context
                              .read<CalendarBloc>()
                              .add(CalendarDaySelected(date));
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showDayBottomSheet(BuildContext context, CalendarState state) {
    final date = state.selectedDate!;
    final niyetler = state.getNiyetlerForDate(date);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DayNiyetlerBottomSheet(
        date: date,
        niyetler: niyetler,
        onDelete: (id) {
          context.read<NiyetBloc>().add(NiyetDeleted(id: id));
          // Refresh calendar to update dots
          context.read<CalendarBloc>().add(const CalendarMonthLoaded());
        },
      ),
    ).then((_) {
      if (context.mounted) {
        context.read<CalendarBloc>().add(const CalendarDayDeselected());
      }
    });
  }
}

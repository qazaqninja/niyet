import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../niyet/domain/entities/niyet.dart';
import '../../domain/usecases/get_niyetler_in_range_usecase.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

@injectable
class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc({
    required GetNiyetlerInRangeUseCase getNiyetlerInRange,
  })  : _getNiyetlerInRange = getNiyetlerInRange,
        super(CalendarState()) {
    on<CalendarMonthLoaded>(_onMonthLoaded);
    on<CalendarMonthChanged>(_onMonthChanged);
    on<CalendarDaySelected>(_onDaySelected);
    on<CalendarDayDeselected>(_onDayDeselected);
  }

  final GetNiyetlerInRangeUseCase _getNiyetlerInRange;

  Future<void> _onMonthLoaded(
    CalendarMonthLoaded event,
    Emitter<CalendarState> emit,
  ) async {
    await _loadMonth(state.focusedMonth, emit);
  }

  Future<void> _onMonthChanged(
    CalendarMonthChanged event,
    Emitter<CalendarState> emit,
  ) async {
    final newMonth = DateTime(event.month.year, event.month.month, 1);
    emit(state.copyWith(focusedMonth: newMonth));
    await _loadMonth(newMonth, emit);
  }

  Future<void> _loadMonth(DateTime month, Emitter<CalendarState> emit) async {
    final monthKey = CalendarState._monthKey(month);

    // Skip if already cached
    if (state.cachedMonths.contains(monthKey)) return;

    emit(state.copyWith(status: CalendarStatus.loading));

    // Calculate range: first day of month to last day
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 0, 23, 59, 59);

    final result = await _getNiyetlerInRange(
      DateRangeParams(start: start, end: end),
    );

    result.when(
      success: (niyetler) {
        // Group by date
        final byDate = <String, List<Niyet>>{...state.niyetlerByDate};
        for (final niyet in niyetler) {
          final key = CalendarState._dateKey(niyet.date);
          byDate[key] = [...(byDate[key] ?? []), niyet];
        }
        emit(state.copyWith(
          status: CalendarStatus.success,
          niyetlerByDate: byDate,
          cachedMonths: {...state.cachedMonths, monthKey},
        ));
      },
      failure: (e) => emit(
        state.copyWith(status: CalendarStatus.failure, error: e.toString()),
      ),
    );
  }

  void _onDaySelected(
    CalendarDaySelected event,
    Emitter<CalendarState> emit,
  ) {
    emit(state.copyWith(selectedDate: event.date));
  }

  void _onDayDeselected(
    CalendarDayDeselected event,
    Emitter<CalendarState> emit,
  ) {
    emit(state.copyWith(clearSelectedDate: true));
  }
}

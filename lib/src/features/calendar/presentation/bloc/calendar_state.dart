part of 'calendar_bloc.dart';

enum CalendarStatus { initial, loading, success, failure }

class CalendarState extends Equatable {
  CalendarState({
    this.status = CalendarStatus.initial,
    DateTime? focusedMonth,
    this.selectedDate,
    this.niyetlerByDate = const {},
    this.cachedMonths = const {},
    this.error,
  }) : focusedMonth = focusedMonth ??
            DateTime(DateTime.now().year, DateTime.now().month, 1);

  final CalendarStatus status;
  final DateTime focusedMonth;
  final DateTime? selectedDate;
  final Map<String, List<Niyet>> niyetlerByDate;
  final Set<String> cachedMonths;
  final String? error;

  bool get isLoading => status == CalendarStatus.loading;
  bool get hasError => status == CalendarStatus.failure;

  List<Niyet> getNiyetlerForDate(DateTime date) {
    final key = _dateKey(date);
    return niyetlerByDate[key] ?? [];
  }

  bool hasNiyetler(DateTime date) => getNiyetlerForDate(date).isNotEmpty;

  bool allReflected(DateTime date) {
    final niyetler = getNiyetlerForDate(date);
    return niyetler.isNotEmpty && niyetler.every((n) => n.isReflected);
  }

  static String _dateKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  static String _monthKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}';

  CalendarState copyWith({
    CalendarStatus? status,
    DateTime? focusedMonth,
    DateTime? selectedDate,
    bool clearSelectedDate = false,
    Map<String, List<Niyet>>? niyetlerByDate,
    Set<String>? cachedMonths,
    String? error,
  }) {
    return CalendarState(
      status: status ?? this.status,
      focusedMonth: focusedMonth ?? this.focusedMonth,
      selectedDate: clearSelectedDate ? null : (selectedDate ?? this.selectedDate),
      niyetlerByDate: niyetlerByDate ?? this.niyetlerByDate,
      cachedMonths: cachedMonths ?? this.cachedMonths,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        focusedMonth,
        selectedDate,
        niyetlerByDate,
        cachedMonths,
        error,
      ];
}

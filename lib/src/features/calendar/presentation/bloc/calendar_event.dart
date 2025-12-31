part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object?> get props => [];
}

class CalendarMonthLoaded extends CalendarEvent {
  const CalendarMonthLoaded();
}

class CalendarMonthChanged extends CalendarEvent {
  const CalendarMonthChanged(this.month);

  final DateTime month;

  @override
  List<Object?> get props => [month];
}

class CalendarDaySelected extends CalendarEvent {
  const CalendarDaySelected(this.date);

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

class CalendarDayDeselected extends CalendarEvent {
  const CalendarDayDeselected();
}

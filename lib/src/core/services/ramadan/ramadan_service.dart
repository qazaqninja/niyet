import 'package:hijri_calendar/hijri_calendar.dart';
import 'package:injectable/injectable.dart';

abstract class RamadanService {
  /// Check if we're currently in Ramadan month
  bool isRamadan();

  /// Check if the given date is today and we're in Ramadan
  bool isRamadanToday(DateTime date);

  /// Get the current Hijri date
  HijriCalendarConfig getHijriDate();
}

@LazySingleton(as: RamadanService)
class RamadanServiceImpl implements RamadanService {
  // Ramadan is the 9th month in the Islamic calendar
  static const int _ramadanMonth = 9;

  @override
  bool isRamadan() {
    final hijri = HijriCalendarConfig.now();
    return hijri.hMonth == _ramadanMonth;
  }

  @override
  bool isRamadanToday(DateTime date) {
    if (!isRamadan()) return false;

    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  HijriCalendarConfig getHijriDate() {
    return HijriCalendarConfig.now();
  }
}

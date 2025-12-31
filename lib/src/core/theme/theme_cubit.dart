import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../services/ramadan/ramadan_service.dart';
import '../services/sun_times/sun_times_service.dart';
import 'animations.dart';
import 'theme.dart';

part 'theme_cubit.freezed.dart';

/// Time period for theme selection
enum TimePeriod {
  /// Morning: After sunrise, before sunset
  morning,

  /// Evening: After sunset, before sunrise
  evening,
}

/// State for the dynamic theme
@Freezed(toJson: false, fromJson: false)
class ThemeState with _$ThemeState {
  const factory ThemeState({
    required TimePeriod timePeriod,
    required bool isRamadan,
    required ThemeData theme,
  }) = _ThemeState;

  const ThemeState._();

  /// Initial state with morning theme
  factory ThemeState.initial() => ThemeState(
        timePeriod: TimePeriod.morning,
        isRamadan: false,
        theme: AppTheme.lightTheme,
      );
}

/// Cubit that manages dynamic theme based on time of day and Ramadan
@injectable
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(
    this._sunTimesService,
    this._ramadanService,
  ) : super(ThemeState.initial());

  final SunTimesService _sunTimesService;
  final RamadanService _ramadanService;

  Timer? _transitionTimer;
  SunTimes? _sunTimes;

  /// Initialize the theme based on current time and Ramadan status
  Future<void> initialize() async {
    // Get sun times for today
    _sunTimes = await _sunTimesService.getTodaySunTimes();

    // Check if it's Ramadan
    final isRamadan = _ramadanService.isRamadan();

    // Determine current time period
    final timePeriod = _getCurrentTimePeriod(_sunTimes!);

    // Update animation settings
    AppAnimations.setEvening(timePeriod == TimePeriod.evening);

    // Compute and emit theme
    final theme = _computeTheme(timePeriod, isRamadan);
    emit(ThemeState(
      timePeriod: timePeriod,
      isRamadan: isRamadan,
      theme: theme,
    ));

    // Schedule next transition
    _scheduleNextTransition(_sunTimes!);
  }

  /// Schedule a timer to trigger at the next sunrise or sunset
  void _scheduleNextTransition(SunTimes sunTimes) {
    _transitionTimer?.cancel();

    final now = DateTime.now();
    DateTime nextTransition;

    if (now.isBefore(sunTimes.sunrise)) {
      // Before sunrise: next transition is sunrise
      nextTransition = sunTimes.sunrise;
    } else if (now.isBefore(sunTimes.sunset)) {
      // After sunrise, before sunset: next transition is sunset
      nextTransition = sunTimes.sunset;
    } else {
      // After sunset: next transition is tomorrow's sunrise
      // Recalculate at midnight to get new sun times
      nextTransition = DateTime(now.year, now.month, now.day + 1, 0, 1);
    }

    final duration = nextTransition.difference(now);

    if (duration.isNegative) {
      // Safety: if somehow negative, check again in a minute
      _transitionTimer = Timer(const Duration(minutes: 1), _onTransition);
    } else {
      _transitionTimer = Timer(duration, _onTransition);
    }
  }

  /// Called when a time transition occurs
  Future<void> _onTransition() async {
    // Refresh sun times (in case we crossed midnight)
    _sunTimes = await _sunTimesService.getTodaySunTimes();

    final isRamadan = _ramadanService.isRamadan();
    final timePeriod = _getCurrentTimePeriod(_sunTimes!);

    // Update animation settings
    AppAnimations.setEvening(timePeriod == TimePeriod.evening);

    // Compute and emit new theme
    final theme = _computeTheme(timePeriod, isRamadan);
    emit(ThemeState(
      timePeriod: timePeriod,
      isRamadan: isRamadan,
      theme: theme,
    ));

    // Schedule next transition
    _scheduleNextTransition(_sunTimes!);
  }

  /// Determine if it's morning or evening based on sun times
  TimePeriod _getCurrentTimePeriod(SunTimes sunTimes) {
    final now = DateTime.now();

    if (now.isAfter(sunTimes.sunrise) && now.isBefore(sunTimes.sunset)) {
      return TimePeriod.morning;
    }
    return TimePeriod.evening;
  }

  /// Compute the appropriate theme based on time period and Ramadan status
  ThemeData _computeTheme(TimePeriod timePeriod, bool isRamadan) {
    ThemeData baseTheme;

    switch (timePeriod) {
      case TimePeriod.morning:
        baseTheme = AppTheme.lightTheme;
      case TimePeriod.evening:
        baseTheme = AppTheme.eveningTheme;
    }

    // Apply Ramadan accent if we're in Ramadan
    if (isRamadan) {
      return AppTheme.withRamadanAccent(baseTheme);
    }

    return baseTheme;
  }

  /// Force refresh the theme (e.g., when app resumes)
  Future<void> refresh() async {
    await _onTransition();
  }

  @override
  Future<void> close() {
    _transitionTimer?.cancel();
    return super.close();
  }
}

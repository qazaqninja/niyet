import 'package:flutter/material.dart';

/// Time-aware animation utilities
///
/// Provides different animation durations and curves based on time of day:
/// - Morning: Faster, more energetic animations (200ms)
/// - Evening: Slower, calmer animations for reflection (450ms)
class AppAnimations {
  const AppAnimations._();

  static bool _isEvening = false;

  /// Update the time period for animations
  static void setEvening(bool value) => _isEvening = value;

  /// Whether we're currently in evening mode
  static bool get isEvening => _isEvening;

  /// Standard animation duration (most UI elements)
  /// Morning: 200ms, Evening: 450ms
  static Duration get standard =>
      Duration(milliseconds: _isEvening ? 450 : 200);

  /// Slow animation duration (emphasis, larger transitions)
  /// Morning: 300ms, Evening: 600ms
  static Duration get slow => Duration(milliseconds: _isEvening ? 600 : 300);

  /// Fast animation duration (micro-interactions)
  /// Morning: 150ms, Evening: 300ms
  static Duration get fast => Duration(milliseconds: _isEvening ? 300 : 150);

  /// Theme transition duration (full app theme change)
  static const Duration themeTransition = Duration(milliseconds: 1500);

  /// Standard animation curve
  /// Morning: easeOut, Evening: gentler easeOutCubic
  static Curve get curve => _isEvening ? Curves.easeOutCubic : Curves.easeOut;

  /// Slow animation curve for emphasis
  static Curve get slowCurve =>
      _isEvening ? Curves.easeInOutCubic : Curves.easeInOut;
}

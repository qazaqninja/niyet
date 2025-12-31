import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_theme.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      primaryContainer: AppColors.primaryLight,
      secondary: AppColors.secondary,
      secondaryContainer: AppColors.secondaryLight,
      tertiary: AppColors.accent,
      surface: AppColors.surface,
      error: Color(0xFFBA1A1A),
      onPrimary: Colors.white,
      onSecondary: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: AppTextTheme.lightTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextTheme.lightTextTheme.titleLarge,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surface,
      indicatorColor: AppColors.primaryLight.withValues(alpha: 0.3),
      labelTextStyle: WidgetStateProperty.all(
        AppTextTheme.lightTextTheme.labelMedium,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.textSecondary.withValues(alpha: 0.1)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.textSecondary.withValues(alpha: 0.2),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.textSecondary.withValues(alpha: 0.2),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryLight,
      primaryContainer: AppColors.primaryDark,
      secondary: AppColors.secondaryLight,
      secondaryContainer: AppColors.secondaryDark,
      tertiary: AppColors.accent,
      surface: AppColors.surfaceDark,
      error: Color(0xFFFFB4AB),
      onPrimary: AppColors.textPrimary,
      onSecondary: AppColors.textPrimary,
      onSurface: AppColors.textPrimaryDark,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    textTheme: AppTextTheme.darkTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundDark,
      foregroundColor: AppColors.textPrimaryDark,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextTheme.darkTextTheme.titleLarge,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surfaceDark,
      indicatorColor: AppColors.primaryLight.withValues(alpha: 0.3),
      labelTextStyle: WidgetStateProperty.all(
        AppTextTheme.darkTextTheme.labelMedium,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surfaceDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppColors.textSecondaryDark.withValues(alpha: 0.1),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.textSecondaryDark.withValues(alpha: 0.2),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.textSecondaryDark.withValues(alpha: 0.2),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
      ),
    ),
  );

  /// Evening theme - warm dark palette for reflection time
  static ThemeData get eveningTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.eveningPrimary,
      primaryContainer: AppColors.eveningPrimaryContainer,
      secondary: AppColors.secondary,
      secondaryContainer: AppColors.secondaryDark,
      tertiary: AppColors.accent,
      surface: AppColors.eveningSurface,
      error: Color(0xFFFFB4AB),
      onPrimary: AppColors.eveningBackground,
      onSecondary: AppColors.eveningTextPrimary,
      onSurface: AppColors.eveningTextPrimary,
    ),
    scaffoldBackgroundColor: AppColors.eveningBackground,
    textTheme: AppTextTheme.eveningTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.eveningBackground,
      foregroundColor: AppColors.eveningTextPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextTheme.eveningTextTheme.titleLarge,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.eveningSurface,
      indicatorColor: AppColors.eveningPrimary.withValues(alpha: 0.3),
      labelTextStyle: WidgetStateProperty.all(
        AppTextTheme.eveningTextTheme.labelMedium,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.eveningSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppColors.eveningTextSecondary.withValues(alpha: 0.1),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.eveningPrimary,
        foregroundColor: AppColors.eveningBackground,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.eveningSurfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.eveningTextSecondary.withValues(alpha: 0.2),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.eveningTextSecondary.withValues(alpha: 0.2),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.eveningPrimary, width: 2),
      ),
    ),
  );

  /// Get theme with optional Ramadan accent applied
  static ThemeData withRamadanAccent(ThemeData baseTheme) {
    return baseTheme.copyWith(
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: AppColors.ramadanPrimary,
        tertiary: AppColors.ramadanAccent,
      ),
    );
  }
}

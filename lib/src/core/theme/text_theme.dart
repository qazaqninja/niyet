import 'package:flutter/material.dart';

import 'colors.dart';

class AppTextTheme {
  const AppTextTheme._();

  static const String _fontFamily = 'Inter';

  static TextTheme get lightTextTheme => TextTheme(
        displayLarge: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          color: AppColors.textPrimary,
        ),
        displayMedium: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 45,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),
        displaySmall: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),
        headlineLarge: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        headlineMedium: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        headlineSmall: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleLarge: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        titleMedium: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: AppColors.textPrimary,
        ),
        titleSmall: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: AppColors.textPrimary,
        ),
        bodyLarge: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: AppColors.textPrimary,
        ),
        bodyMedium: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: AppColors.textPrimary,
        ),
        bodySmall: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: AppColors.textSecondary,
        ),
        labelLarge: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: AppColors.textPrimary,
        ),
        labelMedium: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: AppColors.textPrimary,
        ),
        labelSmall: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: AppColors.textSecondary,
        ),
      );

  static TextTheme get darkTextTheme => TextTheme(
        displayLarge: lightTextTheme.displayLarge?.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        displayMedium: lightTextTheme.displayMedium?.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        displaySmall: lightTextTheme.displaySmall?.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        headlineLarge: lightTextTheme.headlineLarge?.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        headlineMedium: lightTextTheme.headlineMedium?.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        headlineSmall: lightTextTheme.headlineSmall?.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        titleLarge: lightTextTheme.titleLarge?.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        titleMedium: lightTextTheme.titleMedium?.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        titleSmall: lightTextTheme.titleSmall?.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        bodyLarge: lightTextTheme.bodyLarge?.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        bodyMedium: lightTextTheme.bodyMedium?.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        bodySmall: lightTextTheme.bodySmall?.copyWith(
          color: AppColors.textSecondaryDark,
        ),
        labelLarge: lightTextTheme.labelLarge?.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        labelMedium: lightTextTheme.labelMedium?.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        labelSmall: lightTextTheme.labelSmall?.copyWith(
          color: AppColors.textSecondaryDark,
        ),
      );
}

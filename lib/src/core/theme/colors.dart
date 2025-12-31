import 'package:flutter/material.dart';

/// Earth-toned color palette for Niyet app
/// Calm, minimalist, and spiritually grounded
class AppColors {
  const AppColors._();

  // Primary - Sage Green (nature, growth, tranquility)
  static const Color primary = Color(0xFF6B8E6B);
  static const Color primaryLight = Color(0xFF8FB08F);
  static const Color primaryDark = Color(0xFF4A6B4A);

  // Secondary - Warm Sand (warmth, earth, comfort)
  static const Color secondary = Color(0xFFD4B896);
  static const Color secondaryLight = Color(0xFFE8D4BC);
  static const Color secondaryDark = Color(0xFFB89B70);

  // Accent - Soft Gold (intention, hope, light)
  static const Color accent = Color(0xFFD4A574);

  // Neutrals
  static const Color background = Color(0xFFF7F5F2);
  static const Color backgroundDark = Color(0xFF1A1A1A);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF2D2D2D);

  // Text
  static const Color textPrimary = Color(0xFF2D2D2D);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textPrimaryDark = Color(0xFFF5F5F5);
  static const Color textSecondaryDark = Color(0xFFAAAAAA);

  // Semantic - Outcome colors (soft, non-judgmental)
  static const Color fulfilled = Color(0xFF7CB07C); // Soft green
  static const Color tried = Color(0xFFD4A574); // Warm amber
  static const Color missed = Color(0xFF9B9B9B); // Neutral gray (not red!)

  // Category colors
  static const Color ibadah = Color(0xFF6B8E6B); // Sage green
  static const Color akhlaq = Color(0xFF8B7355); // Warm brown
  static const Color family = Color(0xFF7B8FA1); // Soft blue-gray
  static const Color charity = Color(0xFFD4A574); // Warm gold
  static const Color work = Color(0xFF9B8B7B); // Taupe

  // Evening theme - warm dark palette for reflection
  static const Color eveningBackground = Color(0xFF1E1B18); // Warm charcoal
  static const Color eveningSurface = Color(0xFF2A2520); // Warm dark brown
  static const Color eveningSurfaceVariant = Color(0xFF352F28); // Elevated
  static const Color eveningPrimary = Color(0xFFA89B7C); // Warm taupe
  static const Color eveningPrimaryContainer = Color(0xFF3D3528); // Muted gold
  static const Color eveningTextPrimary = Color(0xFFF5F0E8); // Warm white
  static const Color eveningTextSecondary = Color(0xFFB8A99A); // Warm muted

  // Ramadan special
  static const Color ramadanPrimary = Color(0xFF3D5A3D); // Forest green
  static const Color ramadanAccent = Color(0xFFE8C088); // Brighter gold
  static const Color ramadanGlow = Color(0x26D4A574); // 15% opacity for glow
}

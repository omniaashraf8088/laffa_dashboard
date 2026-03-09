import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Background
  static const Color background = Color(0xFF1E1E2F);
  static const Color surface = Color(0xFF2A2A40);
  static const Color surfaceLight = Color(0xFF33334D);

  // Gradient
  static const Color purple = Color(0xFF7C5FFF);
  static const Color purpleLight = Color(0xFF9B5FFF);
  static const Color cyan = Color(0xFF00D9FF);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFE0E0E0);
  static const Color textMuted = Color(0xFF9E9EB8);

  // Status
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFEF5350);
  static const Color info = Color(0xFF29B6F6);

  // ── Glass / overlay alphas ──────────────────────────────────────────
  static Color get glassSurface => surface.withAlpha(180);
  static Color get glassBorder => const Color(0xFFFFFFFF).withAlpha(10);
  static Color get glassShadow => purple.withAlpha(8);
  static Color get shadowDark => const Color(0xFF000000).withAlpha(20);
  static Color get overlayWhiteSubtle => const Color(0xFFFFFFFF).withAlpha(20);
  static Color get overlayWhiteFaint => const Color(0xFFFFFFFF).withAlpha(5);
  static Color get gridLine => textMuted.withAlpha(15);
  static Color get purpleSubtle => purple.withAlpha(25);
  static Color get purpleBorder => purple.withAlpha(40);
  static Color get purpleGlow => purple.withAlpha(60);
  static Color get purpleIndicator => purple.withAlpha(80);
  static Color get purpleHover => purple.withAlpha(15);
  static Color get purpleBadge => purple.withAlpha(30);
  static Color get areaGradientStart => purple.withAlpha(60);
  static Color get areaGradientEnd => cyan.withAlpha(5);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [purple, purpleLight, cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient1 = LinearGradient(
    colors: [Color(0xFF7C5FFF), Color(0xFF9B5FFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient2 = LinearGradient(
    colors: [Color(0xFF9B5FFF), Color(0xFF00D9FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient3 = LinearGradient(
    colors: [Color(0xFF00D9FF), Color(0xFF7C5FFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient4 = LinearGradient(
    colors: [Color(0xFF7C5FFF), Color(0xFF00D9FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static List<LinearGradient> get cardGradients => [
    cardGradient1,
    cardGradient2,
    cardGradient3,
    cardGradient4,
  ];
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.purple,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.purple,
        secondary: AppColors.cyan,
        surface: AppColors.surface,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: AppColors.textMuted),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      dataTableTheme: DataTableThemeData(
        headingTextStyle: GoogleFonts.poppins(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        dataTextStyle: GoogleFonts.poppins(
          color: AppColors.textPrimary,
          fontSize: 13,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF5F6FA),
      primaryColor: AppColors.purple,
      colorScheme: const ColorScheme.light(
        primary: AppColors.purple,
        secondary: AppColors.cyan,
        surface: Colors.white,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}

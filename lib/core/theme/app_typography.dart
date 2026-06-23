import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography system derived from theme.css + fonts.css (Inter via Google Fonts)
abstract class AppTypography {
  // ── Font size scale (matches Tailwind defaults at base 16px) ─────────────────
  static const double textXs = 12.0;
  static const double textSm = 14.0;
  static const double textBase = 16.0;
  static const double textLg = 18.0;
  static const double textXl = 20.0;
  static const double text2xl = 24.0;
  static const double text3xl = 30.0;
  static const double text4xl = 36.0;

  // ── Font weights ──────────────────────────────────────────────────────────────
  static const FontWeight weightNormal = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightSemibold = FontWeight.w600;
  static const FontWeight weightBold = FontWeight.w700;
  static const FontWeight weightExtrabold = FontWeight.w800;
  static const FontWeight weightBlack = FontWeight.w900;

  // ── Line height ───────────────────────────────────────────────────────────────
  static const double lineHeightTight = 1.25;
  static const double lineHeightSnug = 1.375;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.625;

  static TextTheme buildTextTheme() {
    final base = GoogleFonts.interTextTheme();
    return base.copyWith(
      // h1 — 2xl / medium / 1.5
      displayLarge: GoogleFonts.inter(
        fontSize: text2xl,
        fontWeight: weightMedium,
        height: lineHeightNormal,
        color: AppColors.foreground,
      ),
      // h2 — xl / medium / 1.5
      displayMedium: GoogleFonts.inter(
        fontSize: textXl,
        fontWeight: weightMedium,
        height: lineHeightNormal,
        color: AppColors.foreground,
      ),
      // h3 — lg / medium / 1.5
      displaySmall: GoogleFonts.inter(
        fontSize: textLg,
        fontWeight: weightMedium,
        height: lineHeightNormal,
        color: AppColors.foreground,
      ),
      // h4 — base / medium / 1.5
      headlineLarge: GoogleFonts.inter(
        fontSize: textBase,
        fontWeight: weightMedium,
        height: lineHeightNormal,
        color: AppColors.foreground,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: textBase,
        fontWeight: weightMedium,
        height: lineHeightNormal,
        color: AppColors.foreground,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: textSm,
        fontWeight: weightMedium,
        height: lineHeightNormal,
        color: AppColors.foreground,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: textLg,
        fontWeight: weightMedium,
        height: lineHeightNormal,
        color: AppColors.foreground,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: textBase,
        fontWeight: weightMedium,
        height: lineHeightNormal,
        color: AppColors.foreground,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: textSm,
        fontWeight: weightMedium,
        height: lineHeightNormal,
        color: AppColors.foreground,
        letterSpacing: 0.1,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: textBase,
        fontWeight: weightNormal,
        height: lineHeightNormal,
        color: AppColors.foreground,
        letterSpacing: 0.15,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: textSm,
        fontWeight: weightNormal,
        height: lineHeightNormal,
        color: AppColors.foreground,
        letterSpacing: 0.25,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: textXs,
        fontWeight: weightNormal,
        height: lineHeightNormal,
        color: AppColors.mutedForeground,
        letterSpacing: 0.4,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: textBase,
        fontWeight: weightMedium,
        height: lineHeightNormal,
        color: AppColors.foreground,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: textSm,
        fontWeight: weightMedium,
        height: lineHeightNormal,
        color: AppColors.foreground,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: textXs,
        fontWeight: weightMedium,
        height: lineHeightNormal,
        color: AppColors.mutedForeground,
        letterSpacing: 0.5,
      ),
    );
  }
}
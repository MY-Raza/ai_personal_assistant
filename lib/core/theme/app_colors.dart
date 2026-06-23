import 'package:flutter/material.dart';

abstract class AppColors {
  // ── Background ──────────────────────────────────────────────────────────────
  static const Color background = Color(0xFF0F172A); // slate-900
  static const Color card = Color(0x1A1E293B); // rgba(30,41,59,0.8) ≈ CC overlay
  static const Color cardSolid = Color(0xFF1E293B); // slate-800
  static const Color popover = Color(0xFF1E293B); // slate-800
  static const Color muted = Color(0x991E293B); // rgba(30,41,59,0.6)
  static const Color input = Color(0xCC1E293B); // rgba(30,41,59,0.8)
  static const Color switchBackground = Color(0xFF334155); // slate-700

  // ── Foreground ───────────────────────────────────────────────────────────────
  static const Color foreground = Color(0xFFF1F5F9); // slate-100
  static const Color cardForeground = Color(0xFFF1F5F9);
  static const Color popoverForeground = Color(0xFFF1F5F9);
  static const Color mutedForeground = Color(0xFF94A3B8); // slate-400
  static const Color primaryForeground = Color(0xFFFFFFFF);
  static const Color secondaryForeground = Color(0xFFFFFFFF);
  static const Color accentForeground = Color(0xFFFFFFFF);
  static const Color destructiveForeground = Color(0xFFFFFFFF);

  // ── Brand ────────────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF6366F1); // indigo-500
  static const Color secondary = Color(0xFF14B8A6); // teal-500
  static const Color accent = Color(0xFF14B8A6); // teal-500
  static const Color destructive = Color(0xFFEF4444); // red-500
  static const Color ring = Color(0xFF6366F1);

  // ── Border ───────────────────────────────────────────────────────────────────
  static const Color border = Color(0x336366F1); // rgba(99,102,241,0.2)

  // ── Charts ───────────────────────────────────────────────────────────────────
  static const Color chart1 = Color(0xFF6366F1); // indigo
  static const Color chart2 = Color(0xFF14B8A6); // teal
  static const Color chart3 = Color(0xFFF59E0B); // amber
  static const Color chart4 = Color(0xFFEC4899); // pink
  static const Color chart5 = Color(0xFF8B5CF6); // violet

  // ── Sidebar ──────────────────────────────────────────────────────────────────
  static const Color sidebar = Color(0xFF1E293B);
  static const Color sidebarForeground = Color(0xFFF1F5F9);
  static const Color sidebarPrimary = Color(0xFF6366F1);
  static const Color sidebarPrimaryForeground = Color(0xFFFFFFFF);
  static const Color sidebarAccent = Color(0x266366F1); // rgba(99,102,241,0.15)
  static const Color sidebarAccentForeground = Color(0xFFF1F5F9);
  static const Color sidebarBorder = Color(0x336366F1);
  static const Color sidebarRing = Color(0xFF6366F1);

  // ── Semantic helpers ─────────────────────────────────────────────────────────
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF38BDF8);

  // ── Transparent overlays ─────────────────────────────────────────────────────
  static const Color overlay12 = Color(0x1F000000);
  static const Color overlay24 = Color(0x3D000000);
  static const Color white10 = Color(0x1AFFFFFF);
  static const Color white20 = Color(0x33FFFFFF);
}
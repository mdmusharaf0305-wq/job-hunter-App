import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Dark Theme Palette (Main Hub View)
  static const Color darkBackground = Color(0xFF0A0A0E);
  static const Color darkCardBg = Color(0x12FFFFFF); // Translucent glass background
  static const Color darkCardBorder = Color(0x1FFFFFFF); // Backdrop filter outline
  static const Color darkAccentPurple = Color(0xFF8B5CF6);
  static const Color darkAccentBlue = Color(0xFF3B82F6);
  static const Color darkAccentAmber = Color(0xFFF59E0B);
  static const Color darkAccentEmerald = Color(0xFF10B981);
  static const Color darkAccentRed = Color(0xFFEF4444);
  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);

  // Light Theme Palette
  static const Color lightBackground = Color(0xFFF3F4F6);
  static const Color lightCardBg = Color(0xC8FFFFFF);
  static const Color lightCardBorder = Color(0x24000000);
  static const Color lightAccentPurple = Color(0xFF7C3AED);
  static const Color lightAccentBlue = Color(0xFF2563EB);
  static const Color lightAccentAmber = Color(0xFFD97706);
  static const Color lightAccentEmerald = Color(0xFF059669);
  static const Color lightAccentRed = Color(0xFFDC2626);
  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF4B5563);

  // Priority Colors
  static const Color priorityHigh = Color(0xFFEF4444);
  static const Color priorityMedium = Color(0xFFF59E0B);
  static const Color priorityLow = Color(0xFF3B82F6);

  // Column Status Colors (Visual parity with Next.js)
  static Color getStatusColor(String status, bool isDark) {
    final s = status.toLowerCase();
    if (s.contains('shortlist') || s.contains('screening') || s.contains('screen')) {
      return isDark ? darkAccentAmber : lightAccentAmber;
    }
    if (s.contains('resume shared')) {
      return isDark ? darkAccentPurple : lightAccentPurple;
    }
    if (s.contains('no response')) {
      return isDark ? darkAccentBlue : lightAccentBlue;
    }
    if (s.contains('no openings')) {
      return isDark ? darkAccentRed : lightAccentRed;
    }
    if (s.contains('on hold') || s.contains('pause')) {
      return const Color(0xFF71717A);
    }
    if (s.contains('rejected') || s.contains('drop') || s.contains('closed')) {
      return isDark ? darkAccentRed : lightAccentRed;
    }
    if (s.contains('offer') || s.contains('won')) {
      return isDark ? darkAccentEmerald : lightAccentEmerald;
    }
    // Applied / Sourcing / default
    return const Color(0xFF64748B);
  }
}

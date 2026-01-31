import 'package:flutter/material.dart';

/// Application color constants
/// 
/// Defines all colors used throughout the alarm app
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Primary colors - Modern indigo
  static const Color primary = Color(0xFF4F46E5);
  static const Color primaryVariant = Color(0xFF6366F1);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Secondary colors - Emerald green
  static const Color secondary = Color(0xFF10B981);
  static const Color secondaryVariant = Color(0xFF059669);
  static const Color onSecondary = Color(0xFFFFFFFF);

  // Error colors
  static const Color error = Color(0xFFEF4444);
  static const Color onError = Color(0xFFFFFFFF);

  // Background colors
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color onBackgroundLight = Color(0xFF0F172A);
  static const Color onBackgroundDark = Color(0xFFF1F5F9);

  // Surface colors
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color onSurfaceLight = Color(0xFF1E293B);
  static const Color onSurfaceDark = Color(0xFFF1F5F9);

  // Outline colors
  static const Color outline = Color(0xFFCBD5E1);
  static const Color outlineDark = Color(0xFF475569);

  // Alarm-specific colors
  static const Color alarmActive = Color(0xFFEF4444);
  static const Color alarmInactive = Color(0xFF94A3B8);
  static const Color alarmSnooze = Color(0xFFF59E0B);
  static const Color alarmEnabled = Color(0xFF10B981);
  static const Color alarmDisabled = Color(0xFF64748B);

  // Time display colors
  static const Color timeDisplayPrimary = Color(0xFF1E293B);
  static const Color timeDisplaySecondary = Color(0xFF64748B);

  // Card colors
  static const Color cardBackgroundLight = Color(0xFFFFFFFF);
  static const Color cardBackgroundDark = Color(0xFF1E293B);

  // Divider colors
  static const Color dividerLight = Color(0xFFE2E8F0);
  static const Color dividerDark = Color(0xFF334155);
}

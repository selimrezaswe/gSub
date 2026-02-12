import 'package:flutter/material.dart';

/// Application color constants
/// 
/// Defines all colors used throughout the alarm app
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  /// Create a [Color] from a hex code string.
  /// 
  /// Supports strings like "aabbcc", "#aabbcc", "ffaabbcc", or "#ffaabbcc".
  /// If alpha is not provided, it defaults to "ff" (opaque).
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    String cleanHex = hexString.replaceFirst('#', '').replaceAll('0x', '');
    if (cleanHex.length == 6) {
      buffer.write('ff');
    }
    buffer.write(cleanHex);
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  // Primary colors - Modern indigo
  static const Color primary = Color(0xFF4F46E5);
  static const Color primaryVariant = Color(0xFF6366F1);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryLight = Color(0xffEBEFF6);
  static const Color subtitleTextColor = Color(0xff868DA6);

  // Secondary colors - Emerald green
  static const Color secondary = Color(0xFF10B981);
  static const Color secondaryVariant = Color(0xFF059669);
  static const Color onSecondary =  Color(0xff868DA6);

  // Error colors
  static const Color error = Color(0xFFEF4444);
  static const Color onError = Color(0xFFFFFFFF);

  // Background colors
  static const Color backgroundLight = Color.fromARGB(0, 239, 243, 246);
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color onBackgroundLight = Color(0xFF0F172A);
  static const Color onBackgroundDark = Color(0xFFF1F5F9);

  // Surface colors
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00000000);
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

  static const Color yellow = Color(0xFFF9D342);
}

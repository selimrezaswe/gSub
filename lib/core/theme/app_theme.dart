import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constant/app_colors.dart';
import 'app_text_theme.dart';

/// Application theme configuration
///
/// Defines light and dark themes for the alarm app
class AppTheme {
  /// Light theme configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: AppTextTheme.primaryFont,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
        surface: AppColors.surfaceLight,
        onPrimary: AppColors.onSecondary,
        onSecondary: AppColors.onPrimary,
        onError: AppColors.onError,
        onSurface: AppColors.onSurfaceLight,
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: AppColors.surfaceLight,
        foregroundColor: AppColors.onSurfaceLight,
        titleTextStyle: TextStyle(
          fontFamily: AppTextTheme.primaryFont,
          color: AppColors.onSurfaceLight,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: AppColors.surfaceLight,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextTheme.displayLarge.copyWith(
          color: AppColors.onBackgroundLight,
        ),
        displayMedium: AppTextTheme.displayMedium.copyWith(
          color: AppColors.onBackgroundLight,
        ),
        displaySmall: AppTextTheme.displaySmall.copyWith(
          color: AppColors.onBackgroundLight,
        ),
        headlineLarge: AppTextTheme.headlineLarge.copyWith(
          color: AppColors.onBackgroundLight,
        ),
        headlineMedium: AppTextTheme.headlineMedium.copyWith(
          color: AppColors.onBackgroundLight,
        ),
        headlineSmall: AppTextTheme.headlineSmall.copyWith(
          color: AppColors.onBackgroundLight,
        ),
        titleLarge: AppTextTheme.titleLarge.copyWith(
          color: AppColors.onSurfaceLight,
        ),
        titleMedium: AppTextTheme.titleMedium.copyWith(
          color: AppColors.onSurfaceLight,
        ),
        titleSmall: AppTextTheme.titleSmall.copyWith(
          color: AppColors.onSurfaceLight,
        ),
        bodyLarge: AppTextTheme.bodyLarge.copyWith(
          color: AppColors.onBackgroundLight,
        ),
        bodyMedium: AppTextTheme.bodyMedium.copyWith(
          color: AppColors.onBackgroundLight,
        ),
        bodySmall: AppTextTheme.bodySmall.copyWith(
          color: AppColors.onBackgroundLight,
        ),
        labelLarge: AppTextTheme.labelLarge.copyWith(
          color: AppColors.onSurfaceLight,
        ),
        labelMedium: AppTextTheme.labelMedium.copyWith(
          color: AppColors.onSurfaceLight,
        ),
        labelSmall: AppTextTheme.labelSmall.copyWith(
          color: AppColors.onSurfaceLight,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.alarmInactive,
        selectedLabelStyle: TextStyle(
          fontFamily: AppTextTheme.primaryFont,
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: AppTextTheme.primaryFont,
          fontSize: 12,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 4,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  /// Dark theme configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppTextTheme.primaryFont,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
        surface: AppColors.surfaceDark,
        onBackground: AppColors.backgroundDark,
        onPrimary: AppColors.onPrimary,
        onSecondary: AppColors.onSecondary,
        onError: AppColors.onError,
        onSurface: AppColors.onSurfaceDark,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: AppColors.onSurfaceDark,
        titleTextStyle: TextStyle(
          fontFamily: AppTextTheme.primaryFont,
          color: AppColors.onSurfaceDark,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: AppColors.surfaceDark,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextTheme.displayLarge.copyWith(
          color: AppColors.onBackgroundDark,
        ),
        displayMedium: AppTextTheme.displayMedium.copyWith(
          color: AppColors.onBackgroundDark,
        ),
        displaySmall: AppTextTheme.displaySmall.copyWith(
          color: AppColors.onBackgroundDark,
        ),
        headlineLarge: AppTextTheme.headlineLarge.copyWith(
          color: AppColors.onBackgroundDark,
        ),
        headlineMedium: AppTextTheme.headlineMedium.copyWith(
          color: AppColors.onBackgroundDark,
        ),
        headlineSmall: AppTextTheme.headlineSmall.copyWith(
          color: AppColors.onBackgroundDark,
        ),
        titleLarge: AppTextTheme.titleLarge.copyWith(
          color: AppColors.onSurfaceDark,
        ),
        titleMedium: AppTextTheme.titleMedium.copyWith(
          color: AppColors.onSurfaceDark,
        ),
        titleSmall: AppTextTheme.titleSmall.copyWith(
          color: AppColors.onSurfaceDark,
        ),
        bodyLarge: AppTextTheme.bodyLarge.copyWith(
          color: AppColors.onBackgroundDark,
        ),
        bodyMedium: AppTextTheme.bodyMedium.copyWith(
          color: AppColors.onBackgroundDark,
        ),
        bodySmall: AppTextTheme.bodySmall.copyWith(
          color: AppColors.onBackgroundDark,
        ),
        labelLarge: AppTextTheme.labelLarge.copyWith(
          color: AppColors.onSurfaceDark,
        ),
        labelMedium: AppTextTheme.labelMedium.copyWith(
          color: AppColors.onSurfaceDark,
        ),
        labelSmall: AppTextTheme.labelSmall.copyWith(
          color: AppColors.onSurfaceDark,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.alarmInactive,
        selectedLabelStyle: TextStyle(
          fontFamily: AppTextTheme.primaryFont,
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: AppTextTheme.primaryFont,
          fontSize: 12,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 4,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.outlineDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.outlineDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppPalette {
  const AppPalette._();

  static const ink = Color(0xFF1E1A1A);
  static const background = Color(0xFFF4D3C4);
  static const surface = Color(0xFFFFF8F1);
  static const peach = Color(0xFFF7D9C6);
  static const orange = Color(0xFFFFA01B);
  static const lavender = Color(0xFFD5C6E5);
  static const sky = Color(0xFFB8DDE2);
  static const blush = Color(0xFFF2C7D4);
  static const sand = Color(0xFFF4DEAA);
  static const muted = Color(0xFF7B6662);
}

ThemeData buildAppTheme() {
  final baseTextTheme = GoogleFonts.spaceGroteskTextTheme();

  return ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: AppPalette.orange,
      secondary: AppPalette.sky,
      surface: AppPalette.surface,
      onPrimary: AppPalette.ink,
      onSecondary: AppPalette.ink,
      onSurface: AppPalette.ink,
    ),
    scaffoldBackgroundColor: AppPalette.background,
    textTheme: baseTextTheme.copyWith(
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppPalette.ink,
      ),
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppPalette.ink,
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppPalette.ink,
      ),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        color: AppPalette.ink,
        height: 1.35,
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        color: AppPalette.muted,
        height: 1.35,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppPalette.ink,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppPalette.surface,
      hintStyle: baseTextTheme.bodyMedium?.copyWith(color: AppPalette.muted),
      labelStyle: baseTextTheme.bodyMedium?.copyWith(color: AppPalette.muted),
      prefixIconColor: AppPalette.ink,
      enabledBorder: _inputBorder(),
      focusedBorder: _inputBorder(),
      border: _inputBorder(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPalette.orange,
        foregroundColor: AppPalette.ink,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        textStyle: baseTextTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppPalette.ink, width: 2),
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: AppPalette.ink),
  );
}

OutlineInputBorder _inputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(color: AppPalette.ink, width: 2),
  );
}

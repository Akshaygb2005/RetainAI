import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color brandDark = Color(0xFF0C0D12);
  static const Color brandDarkCard = Color(0xFF13151F);
  static const Color brandDarkBorder = Color(0xFF232736);
  static const Color brandOrange = Color(0xFFE65124);
  static const Color brandOrangeHover = Color(0xFFF26235);
  static const Color brandMuted = Color(0xFF8B92A5);

  // Status Colors
  static const Color statusGreen = Color(0xFF10B981);
  static const Color statusGreenBg = Color(0x1A10B981);
  static const Color statusGreenBorder = Color(0x4D10B981);

  static const Color statusRed = Color(0xFFEF4444);
  static const Color statusRedBg = Color(0x1AEF4444);
  static const Color statusRedBorder = Color(0x4DEF4444);

  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);

  // Text Styles
  static TextStyle get displayFont => GoogleFonts.spaceGrotesk(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get sansFont => GoogleFonts.plusJakartaSans(
        color: slate100,
        fontWeight: FontWeight.w400,
      );

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: brandDark,
      primaryColor: brandOrange,
      colorScheme: const ColorScheme.dark(
        primary: brandOrange,
        secondary: brandOrangeHover,
        surface: brandDarkCard,
        onSurface: slate100,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        ThemeData.dark().textTheme,
      ).apply(
        bodyColor: slate100,
        displayColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: brandDark,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintStyle: const TextStyle(color: slate600, fontSize: 13),
        labelStyle: const TextStyle(color: slate300, fontSize: 13),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0x1AFFFFFF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: brandOrange, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: statusRed),
        ),
      ),
    );
  }
}

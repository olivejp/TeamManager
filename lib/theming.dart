import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_manager/constants.dart';

class Theming {
  static ThemeData buildThemeData() {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xff1d1b26),
      primarySwatch: Colors.grey,
      colorScheme: ColorScheme.fromSeed(seedColor: Constants.primaryColor),
      textTheme: TextTheme(
        labelSmall: GoogleFonts.nunito(
          fontWeight: FontWeight.w500,
          color: Colors.black87,
          fontSize: 10,
        ),
        displayLarge: GoogleFonts.nunito(
          fontWeight: FontWeight.w900,
          color: Colors.grey,
          fontSize: 50,
        ),
        titleLarge: GoogleFonts.nunito(
          fontWeight: FontWeight.w500,
          color: Colors.grey,
          fontSize: 20,
        ),
        bodySmall: GoogleFonts.nunito(
          color: Colors.grey,
          fontSize: 16,
        ),
        titleMedium: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 18,
        ),
        titleSmall: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.25,
        ),
        bodyLarge: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );
  }

  static ThemeData buildThemeDataDark() {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xff1d1b26),
      primarySwatch: Colors.grey,
      colorScheme: ColorScheme.fromSeed(seedColor: Constants.primaryColor),
      cardTheme: const CardTheme(color: Constants.backgroundColor),
      dialogTheme: const DialogTheme(backgroundColor: Constants.backgroundColor),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.nunito(
          fontWeight: FontWeight.w900,
          color: Colors.grey,
          fontSize: 50,
        ),
        titleLarge: GoogleFonts.nunito(
          fontWeight: FontWeight.w500,
          color: Colors.grey,
          fontSize: 20,
        ),
        bodySmall: GoogleFonts.nunito(
          color: Colors.grey,
          fontSize: 16,
        ),
        titleMedium: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 18,
        ),
        titleSmall: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.25,
        ),
        bodyLarge: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );
  }
}

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
        headline1: GoogleFonts.nunito(
          fontWeight: FontWeight.w900,
          color: Colors.grey,
          fontSize: 50,
        ),
        headline6: GoogleFonts.nunito(
          fontWeight: FontWeight.w500,
          color: Colors.grey,
          fontSize: 20,
        ),
        caption: GoogleFonts.nunito(
          color: Colors.grey,
          fontSize: 16,
        ),
        subtitle1: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 18,
        ),
        subtitle2: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.25,
        ),
        bodyText1: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyText2: GoogleFonts.nunito(
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
      textTheme: TextTheme(
        headline1: GoogleFonts.nunito(
          fontWeight: FontWeight.w900,
          color: Colors.grey,
          fontSize: 50,
        ),
        headline6: GoogleFonts.nunito(
          fontWeight: FontWeight.w500,
          color: Colors.grey,
          fontSize: 20,
        ),
        caption: GoogleFonts.nunito(
          color: Colors.grey,
          fontSize: 16,
        ),
        subtitle1: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 18,
        ),
        subtitle2: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.25,
        ),
        bodyText1: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyText2: GoogleFonts.nunito(
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

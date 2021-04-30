import 'package:covid_care/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrandTheme {
  static get themeData => ThemeData(
        primaryColor: BrandColors.blue,
        backgroundColor: BrandColors.black,
        textTheme: TextTheme(
          headline1: GoogleFonts.raleway(fontSize: 24, color: Colors.black),
          bodyText1: GoogleFonts.raleway(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: GoogleFonts.raleway(fontSize: 18, color: Colors.black),
          subtitle1: GoogleFonts.raleway(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headline2: GoogleFonts.raleway(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}

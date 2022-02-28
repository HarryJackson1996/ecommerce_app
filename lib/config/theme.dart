import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Set<ThemeData> appTheme = <ThemeData>{
  ThemeData(
    canvasColor: const Color.fromARGB(255, 228, 228, 228),
    primaryColor: const Color.fromARGB(255, 0, 0, 0),
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.notoSans(
        fontSize: 14.0,
        fontWeight: FontWeight.w300,
      ),
      bodyText2: GoogleFonts.notoSans(
        fontSize: 17.0,
        fontWeight: FontWeight.w800,
      ),
      headline1: GoogleFonts.notoSans(
        fontWeight: FontWeight.w800,
        fontSize: 37.0,
      ),
      headline2: GoogleFonts.notoSans(
        fontWeight: FontWeight.w800,
        fontSize: 25.0,
      ),
      headline3: GoogleFonts.notoSans(
        fontSize: 15.0,
        fontWeight: FontWeight.w800,
      ),
      button: GoogleFonts.notoSans(
        fontSize: 15.0,
        fontWeight: FontWeight.w800,
      ),
    ),
  ),
};

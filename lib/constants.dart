import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan.shade800),
  textTheme: TextTheme(
    titleLarge: GoogleFonts.pressStart2p(
      fontSize: 24,
    ),
    bodyLarge: GoogleFonts.heebo(
      fontSize: 14,
    ),
  ),
  appBarTheme: AppBarTheme(
    color: Colors.cyan.shade800,
    titleTextStyle: const TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
);

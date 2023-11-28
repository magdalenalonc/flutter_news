import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade400),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.pressStart2p(
        fontSize: 25,
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
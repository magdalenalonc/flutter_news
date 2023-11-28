import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/news_list.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News!',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade400),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.pressStart2p(
            fontSize: 25,
          ),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.blueGrey,
          titleTextStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      home: const NewsList(),
    );
  }
}

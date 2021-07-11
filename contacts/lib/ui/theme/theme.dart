import 'package:flutter/material.dart';

final theme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.pink,
  primaryColor: const Color(0xFF0C0C0C),
  accentColor: const Color(0xFFF35353),
  scaffoldBackgroundColor: const Color(0xFF0C0C0C),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: true,
  ),
  fontFamily: 'Acme',
  inputDecorationTheme: const InputDecorationTheme(
    errorStyle: TextStyle(fontSize: 14, letterSpacing: 1, height: 0),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 2.5, color: Colors.pink),
    ),
  ),
);

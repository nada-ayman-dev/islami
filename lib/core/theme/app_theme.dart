import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF202020),

    primaryColor: const Color(0xFFB7935F),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFB7935F),
      centerTitle: true,
      elevation: 0,
    ),
  );
}
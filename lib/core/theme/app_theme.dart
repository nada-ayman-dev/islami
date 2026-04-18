import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Janna LT',
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Janna LT'),
    primaryTextTheme: ThemeData.light().primaryTextTheme.apply(
      fontFamily: 'Janna LT',
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: const TextStyle(
        fontFamily: 'Janna LT',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    ),
  );
}

import 'package:blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

// Custom Global Theme
class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    // scaffold background color will apply to all pages
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    // appbar background color will apply to all pages
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
      surfaceTintColor: AppPallete.transparentColor,
    ),
    // chip color will apply to all pages
    chipTheme: const ChipThemeData(
      color: MaterialStatePropertyAll(AppPallete.backgroundColor),
      side: BorderSide.none,
    ),
    // input decoration for textformfield will apply to all pages
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(18.0),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
      hintStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
      ),
    ),
  );
}

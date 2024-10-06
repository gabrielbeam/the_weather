import 'dart:io';

import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    /// TODO : Define All ThemeData
    primaryColor: Color(0xFF7437FF),
    primaryColorDark: Color(0xFF5022FF),
    colorScheme: ColorScheme.fromSwatch().copyWith(background: Colors.white),

    scaffoldBackgroundColor: Colors.white,

    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF1F1F1F))),

    /// We can define common use ElevatedButton Style,
    /// so we don't have to check isLight in code
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF7437FF),
        disabledBackgroundColor: Color(0xFF7437FF),
      ),
    ),
    fontFamily: 'Roboto',

    /// Remove defaukt shadow for tile and button
    dividerColor: Color.fromARGB(0, 0, 0, 0),

    /// Remove ripple effect when pressed
    splashColor: Color.fromARGB(0, 0, 0, 0),
    highlightColor: Color.fromARGB(0, 0, 0, 0),

    ///We can define common use textTheme here(both in darkTheme)
    ///so we don't have to check isLight in code
    textTheme: TextTheme(
      headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: Colors.black,
          height: 1.2),
      headlineMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFFC6C2D7)),
      bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFFC6C2D7)),
      displayMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFFF6F2FF)),
      displaySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xF8F8FAFA)),
    ),
    buttonTheme: const ButtonThemeData(
      alignedDropdown: true,
    ),
  );
}

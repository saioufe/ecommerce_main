import 'package:flutter/material.dart';

enum AppTheme { White, Dark }

/// Returns enum value name without enum class name.
String enumName(AppTheme anyEnum) {
  return anyEnum.toString().split('.')[1];
}

final appThemeData = {
  AppTheme.White: ThemeData(
    fontFamily: 'tajawal',
    canvasColor: Color.fromRGBO(243, 248, 253, 1),
    primaryColor: Color.fromRGBO(250, 179, 48, 1),
    accentColor: Color.fromRGBO(255, 189, 67, 1),
    bottomAppBarColor: Color(0xff313e4b),
    appBarTheme: AppBarTheme(
      color: Color(0xFF37d2b3),
      textTheme: TextTheme(
        title: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
  AppTheme.Dark: ThemeData(
    fontFamily: 'tajawal',
    canvasColor: Color(0xff222324),
    primaryColor: Color.fromRGBO(250, 179, 48, 1),
    accentColor: Color.fromRGBO(255, 189, 67, 1),
    bottomAppBarColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Color(0xFF37d2b3),
      textTheme: TextTheme(
        title: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
};

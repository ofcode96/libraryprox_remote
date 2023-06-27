import 'package:flutter/material.dart';
import 'package:libraryprox_remote/constents/globales.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    elevation: 1,
    backgroundColor: Globals.primaryColor,
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    textStyle: TextStyle(color: Colors.black),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Globals.primaryColor,
  ),
);

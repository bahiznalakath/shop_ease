import 'package:flutter/material.dart';

const colorWhite = Color(0xFFFFFFFF);
const primaryColor = Color(0xFFFF7F50);
const colorTextWhite = Color(0xffF1F6FA);
const bottomIconColor = Color(0xffBBBFD0);
const borderColor = Color(0xffDEE3ED);
const colorMediumGrey = Color(0xd3453c39);
const colorIconGrey = Color(0xffD9D9D9);
const colorTextBlack = Color(0xff1E2022);
ThemeData appTheme = ThemeData(
  useMaterial3: false,
  indicatorColor: primaryColor,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: colorWhite,
  primarySwatch: MaterialColor(
    primaryColor.value,
    <int, Color>{
      50: Color(0xFFFFEBE6),
      100: Color(0xFFFFCEC0),
      200: Color(0xFFFFAD96),
      300: Color(0xFFFF8B6C),
      400: Color(0xFFFF7350),
      500: primaryColor, // Base color
      600: Color(0xFFE67248),
      700: Color(0xFFCC673F),
      800: Color(0xFFB35C36),
      900: Color(0xFF994E2C),
    },
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: colorWhite,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: colorWhite,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[200],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: primaryColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: primaryColor, width: 2),
    ),
    labelStyle: TextStyle(color: primaryColor),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: colorWhite, // Text color for ElevatedButton
      backgroundColor: primaryColor, // Button background color
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primaryColor, // Text color for TextButton
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
);


// ignore_for_file: prefer_const_constructors

//********************------------- these are the theme by which is for reusable widget deccoretion or all things.  -------------********************//

import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  //********************------------- background color for all apps  -------------********************//
  scaffoldBackgroundColor: Colors.white,


  //********************------------- Elevated button theme -------------********************//
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      disabledBackgroundColor: Colors.grey,
      textStyle: TextStyle(
        fontSize: 15,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  //********************------------- this is the textformfields deccoration theme  -------------********************//


  inputDecorationTheme: InputDecorationTheme(
    border: outlineInputBorder,
    errorBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    disabledBorder: outlineInputBorder,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: Colors.red),
    ),
  ),
  primarySwatch: Colors.red,
);

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey,
  ),
);

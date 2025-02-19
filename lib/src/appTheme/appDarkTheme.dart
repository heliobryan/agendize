import 'package:flutter/material.dart';
import 'package:agendize/src/globalConstants/appFont.dart';

final ThemeData agendizeDarkTheme = ThemeData(
  primaryColor: Color(0xFF34495E),
  hintColor: Color(0xFF2980B9),
  scaffoldBackgroundColor: Color(0xFF121212),
  textTheme: TextTheme(
    bodyLarge: principalFont.regular(
        color: Colors.white), // Usando a fonte personalizada
    bodyMedium: principalFont.regular(color: Colors.white),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    elevation: 0,
    titleTextStyle: principalFont.bold(color: Colors.white, fontSize: 20),
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: Color(0xFF1E1E1E),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF2980B9),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFBDC3C7)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFBDC3C7)),
    ),
  ),
  fontFamily: 'STRETCH', // Definindo a fonte principal aqui também
);

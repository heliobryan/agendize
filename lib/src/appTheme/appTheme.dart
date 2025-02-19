// ignore: file_names
import 'package:agendize/src/globalConstants/appFont.dart';
import 'package:flutter/material.dart';

final ThemeData agendizeTheme = ThemeData(
  primaryColor: Color(0xFF2C3E50),
  hintColor: Color(0xFF3498DB),
  scaffoldBackgroundColor: Color(0xFFF5F7FA),
  textTheme: TextTheme(
    bodyLarge: principalFont.regular(
        color: Color(0xFF2C3E50)), // Fonte personalizada para bodyLarge
    bodyMedium: principalFont.regular(
        color: Color(0xFF2C3E50)), // Fonte personalizada para bodyMedium
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF2C3E50),
    elevation: 0,
    titleTextStyle: principalFont.bold(
      // Fonte personalizada para o título da AppBar
      color: Colors.white,
      fontSize: 20,
    ),
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: Color(0xFF2C3E50),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF3498DB),
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
  fontFamily: 'STRETCH', // Aplicando a fonte 'STRETCH' como fonte padrão
);

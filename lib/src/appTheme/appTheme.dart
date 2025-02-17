import 'package:flutter/material.dart';

final ThemeData agendizeTheme = ThemeData(
  primaryColor: Color(0xFF2C3E50), // Cor da AppBar
  hintColor: Color(0xFF3498DB), // Cor dos Botões
  scaffoldBackgroundColor: Color(0xFFF5F7FA), // Cor do Plano de Fundo
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF2C3E50)), // Cor do texto
    bodyMedium: TextStyle(color: Color(0xFF2C3E50)), // Cor do texto
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF2C3E50), // Cor da AppBar
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: Color(0xFF2C3E50), // Cor do BottomAppBar
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF3498DB), // Cor dos Botões
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFBDC3C7)), // Cor do contorno
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFBDC3C7)), // Cor do contorno
    ),
  ),
  fontFamily: 'Poppins', // Fonte escolhida
);

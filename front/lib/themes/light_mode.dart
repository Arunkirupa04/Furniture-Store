import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    colorScheme: ColorScheme.light(
  background: Color(0xFFF0F0F2), // BG
  primary: Color(0xFF0C8A7B), //Primary
  secondary: Color(0xFF828A89), // For Secondary text in Background
  tertiary: Colors.black, // For Text in Background
  inversePrimary: Colors.white, // For Text in Primary Color
  onPrimary: Colors.white,
  onBackground: Colors.black,
  surface: Colors.white,
  onSurface: Color(0xffF2A666),
));

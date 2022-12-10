import 'package:flutter/material.dart';

class BaseColor {
  // static const Color russianViolet = Color(0x150433);
  // static const Color lavender = Color(0xE2DBFD);
  // static const Color razzmatazz =  Color(0xF61067);
  // static const Color seaGreen =  Color(0x00F0B5);

  static const int _purplePrimaryValue = 0x5E239DFF;
  static const MaterialColor purple = MaterialColor(
    _purplePrimaryValue, 
    <int, Color> {
      50: Color(0x5E239DFF),
      100: Color(_purplePrimaryValue),
      200: Color(_purplePrimaryValue),
      300: Color(_purplePrimaryValue),
      400: Color(_purplePrimaryValue),
      500: Color(0x5E239DFF),
      600: Color(_purplePrimaryValue),
      700: Color(_purplePrimaryValue),
      800: Color(_purplePrimaryValue),
      900: Color(_purplePrimaryValue)
    }
  );
}
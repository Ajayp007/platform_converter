import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorSchemeSeed:
      MaterialStateColor.resolveWith((states) => Colors.blue.shade50),
);

ThemeData darkTheme = ThemeData(
  colorSchemeSeed:
      MaterialStateColor.resolveWith((states) => Colors.green.shade50),
);

import 'package:flutter/material.dart';

ThemeData light_themes = ThemeData(
  colorSchemeSeed:
      MaterialStateColor.resolveWith((states) => Colors.blue.shade50),
);

ThemeData dark_theme = ThemeData(
  colorSchemeSeed:
      MaterialStateColor.resolveWith((states) => Colors.green.shade50),
);

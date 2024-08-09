import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:platform_converter/screen/home/provider/contact_provider.dart';
import 'package:platform_converter/utils/ios_theme.dart';
import 'package:platform_converter/utils/routs.dart';

import 'package:platform_converter/utils/theme_provider.dart';
import 'package:platform_converter/utils/themes.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ContactProvider()),
        ChangeNotifierProvider.value(value: ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          value.setTheme();
          return value.isAndroid
              ? MaterialApp(
                  debugShowCheckedModeBanner: false,
                  routes: androidRouts,
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: value.themeMode == true
                      ? ThemeMode.light
                      : ThemeMode.dark,
                )
              : CupertinoApp(
                  debugShowCheckedModeBanner: false,
                  routes: iosRouts,
                  theme: value.themeMode == true ? light : dark,
                );
        },
      ),
    ),
  );
}

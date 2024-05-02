import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:platform_converter/screen/home/provider/contact_provider.dart';
import 'package:platform_converter/utils/routs.dart';
import 'package:platform_converter/utils/shared_pref.dart';
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
          getThemeMode();
          getIntroScreen();
          return value.isAndroid
              ? MaterialApp(
                  debugShowCheckedModeBanner: false,
                  routes: androidRouts,
                  theme: light_themes,
                  darkTheme: dark_theme,
                  themeMode: value.themeMode == null
                      ? ThemeMode.system
                      : value.themeMode == 'light'
                          ? ThemeMode.light
                          : value.themeMode == 'dark'
                              ? ThemeMode.dark
                              : ThemeMode.system,
                )
              : CupertinoApp(
                  debugShowCheckedModeBanner: false,
                  routes: iosRouts,
                );
        },
      ),
    ),
  );
}

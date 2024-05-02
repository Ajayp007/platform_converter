import 'package:flutter/material.dart';
import 'package:platform_converter/utils/shared_pref.dart';

class ThemeProvider with ChangeNotifier {
  String? themeMode;
  bool isAndroid = true;
  int pageIndex = 0;



  void changePlatform() {
    isAndroid = !isAndroid;
    notifyListeners();
  }

  void changeIndex({required index}) {
    pageIndex = index;
    notifyListeners();
  }
  void setTheme() async {
    themeMode = await getThemeMode();
    notifyListeners();
  }
}

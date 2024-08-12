import 'package:flutter/material.dart';
import 'package:platform_converter/utils/shared_pref.dart';

class ThemeProvider with ChangeNotifier {
  bool themeMode = true;
  bool isAndroid = true;
  int pageIndex = 0;
  bool showProfile = false;

  String? profileSwitch;

  void selectedProfile() {
    showProfile = !showProfile;
    notifyListeners();
  }

  void profile(String switchProfile) {
    profileSwitch = switchProfile;
    notifyListeners();
  }

  void changePlatform() {
    isAndroid = !isAndroid;
    notifyListeners();
  }

  void changeIndex({required index}) {
    pageIndex = index;
    notifyListeners();
  }

  void setTheme() async {
    if (SharedHelper.helper.getThemeData != null) {
      themeMode = await SharedHelper.helper.getThemeData();
    } else {
      themeMode = true;
    }

    notifyListeners();
  }
}

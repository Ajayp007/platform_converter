import 'package:shared_preferences/shared_preferences.dart';

Future<String?> setThemeMode(String themeMode) async {
  SharedPreferences srth = await SharedPreferences.getInstance();

  await srth.setString('themeMode', themeMode);
}

Future<String?> getThemeMode() async {
  String? data;
  SharedPreferences srth = await SharedPreferences.getInstance();
  data = srth.getString('themeMode');
  return data;
}

void setIntroScreen(bool intro) async {
  SharedPreferences firstIntro = await SharedPreferences.getInstance();
  await firstIntro.setBool('firstTime', intro);
}

Future <bool?> getIntroScreen()async{
  bool? secIntro;

  SharedPreferences firstIntro = await SharedPreferences.getInstance();
  secIntro = firstIntro.getBool('firstTime');

  return secIntro;

}

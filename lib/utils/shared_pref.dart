import 'package:shared_preferences/shared_preferences.dart';

void setThemeData(bool themeData) async {
  SharedPreferences shr = await SharedPreferences.getInstance();
  await shr.setBool('true', themeData);
}

Future<bool> getThemeData() async {
  bool? data;

  SharedPreferences shr = await SharedPreferences.getInstance();
  data = shr.getBool('true');
  return data!;
}

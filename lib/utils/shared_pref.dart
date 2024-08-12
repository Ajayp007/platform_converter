import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper
{

static  SharedHelper helper = SharedHelper._();
  SharedHelper._();

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

  Future<void> setUserName(String name) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    await shr.setString('name', name);
  }

  Future<String> getUserName() async {
    String? name;
    SharedPreferences shr = await SharedPreferences.getInstance();
    name = shr.getString('name')!;

    return name;
  }

  Future<void> setUserBio(String bio) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    await shr.setString('bio', bio);
  }

  Future<String> getUserBio() async {
    String? bio;
    SharedPreferences shr = await SharedPreferences.getInstance();
    bio = shr.getString('bio')!;
    return bio;
  }

  Future<void> setUserImage(String image) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    await shr.setString('image', image);
  }

  Future<String> getUserImage() async {
    String? image;
    SharedPreferences shr = await SharedPreferences.getInstance();
    image = shr.getString('image')!;
    return image;
  }

}
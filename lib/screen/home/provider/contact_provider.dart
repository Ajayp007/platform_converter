import 'package:flutter/material.dart';
import 'package:platform_converter/screen/home/model/contact_model.dart';

import '../../../utils/shared_pref.dart';

class ContactProvider with ChangeNotifier {
  List<ContactModel> contactList = [];
  List<UserModel> userList = [];
  DateTime changeDate = DateTime.now();
  DateTime changeIOsTime = DateTime.now();
  TimeOfDay changeTime = TimeOfDay.now();
  String image = "";
  String userName = "";
  String userBio = "";

  void addContact(ContactModel c1) {
    contactList.add(c1);
    notifyListeners();
  }

  void selectedData(DateTime date) {
    changeDate = date;
    notifyListeners();
  }

  void selectedIOSTime(DateTime date) {
    changeIOsTime = date;
    notifyListeners();
  }

  void selectedTime(TimeOfDay time) {
    changeTime = time;
    notifyListeners();
  }

  Future<void> setUserName() async {
    userName = await getUserName();
    notifyListeners();
  }

  Future<void> setUserBio() async {
    userBio = await getUserBio();
    notifyListeners();
  }

  Future<void> selectedImage() async {
    image = await getUserImage();
    notifyListeners();
  }
}

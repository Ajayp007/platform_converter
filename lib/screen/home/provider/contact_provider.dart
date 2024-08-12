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
    if (await SharedHelper.helper.getUserName() != null) {
      userName = await SharedHelper.helper.getUserName();
    } else {
      userName = "";
    }
    notifyListeners();
  }

  Future<void> setUserBio() async {
    if (await SharedHelper.helper.getUserBio() != null) {
      userBio = await SharedHelper.helper.getUserBio();
    } else {
      userBio = "";
    }
    notifyListeners();
  }

  Future<void> selectedImage() async {
    if (await SharedHelper.helper.getUserImage() != null) {
      image = await SharedHelper.helper.getUserImage();
    } else {
      image = "";
    }
    notifyListeners();
  }
}

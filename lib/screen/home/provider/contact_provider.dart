import 'package:flutter/material.dart';
import 'package:platform_converter/screen/home/model/contact_model.dart';

class ContactProvider with ChangeNotifier {
  List<ContactModel> contactList = [];
  DateTime changeDate = DateTime.now();
  TimeOfDay changeTime = TimeOfDay.now();

  void addContact(ContactModel c1) {
    contactList.add(c1);
    notifyListeners();
  }

  void seletedData(DateTime date) {
    changeDate = date;
    notifyListeners();
  }

  void selectedTime(TimeOfDay time) {
    changeTime = time;
    notifyListeners();
  }
}

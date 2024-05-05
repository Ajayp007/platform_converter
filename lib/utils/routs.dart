import 'package:flutter/material.dart';
import 'package:platform_converter/screen/addnew/add_new_contact.dart';
import 'package:platform_converter/screen/addnew/ios_add_new_contact.dart';
import 'package:platform_converter/screen/details/contact_details.dart';
import 'package:platform_converter/screen/details/ios_contact_details.dart';

import 'package:platform_converter/screen/home/view/home_screen.dart';
import 'package:platform_converter/screen/home/view/ios_home_screen.dart';

Map<String, WidgetBuilder> androidRouts = {
  '/': (context) => const HomeScreen(),
  'addContact': (context) => const AddNewContact(),
  'details': (context) => const ContactDetails(),
};

Map<String, WidgetBuilder> iosRouts = {
  '/': (context) => const IHomeScreen(),
  'iosAdd': (context) => const IosAddNewContact(),
  'iosDetails': (context) => const IosContactDetails(),
};

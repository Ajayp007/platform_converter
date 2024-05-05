import 'package:flutter/material.dart';

class ContactModel
{
  String? name,mobile,image,chat;
  DateTime? date;
  TimeOfDay? time;

  ContactModel({this.name,this.image,this.mobile,this.chat,this.date,this.time});
}

class UserModel
{
  String? uName,bio,uImage;

  UserModel({this.uName,this.bio,this.uImage});
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/theme_provider.dart';
import '../home/provider/contact_provider.dart';


class IChatScreen extends StatefulWidget {
  const IChatScreen({super.key});

  @override
  State<IChatScreen> createState() => _IChatScreenState();
}

class _IChatScreenState extends State<IChatScreen> {
  ThemeProvider? providerR;
  ThemeProvider? providerW;
  @override
  Widget build(BuildContext context) {
    providerR = context.read<ThemeProvider>();
    providerW = context.watch<ThemeProvider>();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Contact App'),
        trailing: CupertinoSwitch(
          value: providerW!.isAndroid,
          onChanged: (value) {
            providerR!.changePlatform();
          },
        ),
      ),
      child: Consumer<ContactProvider>(
        builder: (context, value, child) => ListView.builder(
          itemCount: value.contactList.length,
          itemBuilder: (context, index) {
            return CupertinoListTile(
              leading: value.contactList[index].image == null
                  ? const CircleAvatar()
                  : CircleAvatar(
                backgroundImage: FileImage(
                  File("${value.contactList[index].image}"),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              title: Text(
                "${value.contactList[index].name}",
              ),
              subtitle: Text(
                " ${value.contactList[index].chat}",
              ),
              trailing: Text(
                  "${value.contactList[index].date!.day}/${value.contactList[index].date!.month}/${value.contactList[index].date!.year},${value.contactList[index].time!.hour}:${value.contactList[index].time!.minute}"),
            );
          },
        ),
      ),
    );
  }
}

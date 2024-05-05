import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/screen/home/provider/contact_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/theme_provider.dart';

class ICallScreen extends StatefulWidget {
  const ICallScreen({super.key});

  @override
  State<ICallScreen> createState() => _ICallScreenState();
}

class _ICallScreenState extends State<ICallScreen> {
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
              onTap: () {
                Navigator.pushNamed(context, 'iosDetails',arguments: index);
              },
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
                " ${value.contactList[index].mobile}",
              ),
              trailing: CupertinoButton(
                onPressed: () async {
                  String call = "tel:+91${value.contactList[index].mobile}";
                  await launchUrl(Uri.parse(call));
                },
                child: const Icon(CupertinoIcons.phone),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/contact_provider.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ContactProvider>(
        builder: (context, value, child) => ListView.builder(
          itemCount: value.contactList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'details', arguments: index);
              },
              leading: value.contactList[index].image == null
                  ? const CircleAvatar()
                  : CircleAvatar(
                      backgroundImage: FileImage(
                        File("${value.contactList[index].image}"),
                      ),
                    ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              title: Text(
                "${value.contactList[index].name}",
              ),
              subtitle: Text(
                " ${value.contactList[index].mobile}",
              ),
              trailing: IconButton(
                onPressed: () async {
                  String call =
                      "tel:+91${value.contactList[index].mobile}";
                  await launchUrl(Uri.parse(call));
                },
                icon: const Icon(Icons.phone),
              ),
            );
          },
        ),
      ),
    );
  }
}

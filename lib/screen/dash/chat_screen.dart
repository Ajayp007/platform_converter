import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/provider/contact_provider.dart';



class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ContactProvider>(
        builder: (context, value, child) => ListView.builder(
          itemCount: value.contactList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {

              },
              leading: value.contactList[index].image == null
                  ? const CircleAvatar()
                  : CircleAvatar(
                      backgroundImage: FileImage(
                        File("${value.contactList[index].image}"),
                      ),
                    ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20),
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

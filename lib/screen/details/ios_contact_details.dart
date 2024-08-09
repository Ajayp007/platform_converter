import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home/provider/contact_provider.dart';

class IosContactDetails extends StatefulWidget {
  const IosContactDetails({super.key});

  @override
  State<IosContactDetails> createState() => _IosContactDetailsState();
}

class _IosContactDetailsState extends State<IosContactDetails> {
  ContactProvider? providerR;
  ContactProvider? providerW;

  @override
  Widget build(BuildContext context) {
    providerR = context.read<ContactProvider>();
    providerW = context.watch<ContactProvider>();
    int index = ModalRoute.of(context)!.settings.arguments as int;
    return CupertinoPageScaffold(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12,right: 12,top: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: FileImage(
                    File("${providerR!.contactList[index].image}"),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text("${providerR!.contactList[index].name}"),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CupertinoButton(
                    child: const Icon(CupertinoIcons.phone),
                    onPressed: () async {
                      String call =
                          "tel:+91${providerR!.contactList[index].mobile}";
                      await launchUrl(Uri.parse(call));
                    },
                  ),
                  CupertinoButton(
                    child: const Icon(CupertinoIcons.chat_bubble),
                    onPressed: () async {
                      String call =
                          "tel:+91${providerR!.contactList[index].chat}";
                      await launchUrl(Uri.parse(call));
                    },
                  ),
                  const Icon(CupertinoIcons.video_camera),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 120,
                margin: const EdgeInsets.only(top: 10),
                alignment: Alignment.topLeft,
                width: MediaQuery.sizeOf(context).width * 0.9,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Contact Info"),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.phone),
                        Flexible(
                          child: CupertinoListTile(
                            title: Text(
                                "+91 ${providerR!.contactList[index].mobile}"),
                            subtitle: const Text("Phone"),
                          ),
                        ),
                        const Icon(CupertinoIcons.video_camera),
                        const SizedBox(width: 20),
                        const Icon(CupertinoIcons.chat_bubble),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.topLeft,
                width: MediaQuery.sizeOf(context).width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Connected Apps"),
                    const Spacer(),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/wp.png",
                          fit: BoxFit.cover,
                          height: 40,
                          width: 40,
                          filterQuality: FilterQuality.medium,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text("WhatsApp"),
                        const Spacer(),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const Align(
                alignment: Alignment.topLeft,
                child: Text("Contact Settings"),
              ),
              const SizedBox(height: 20),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(CupertinoIcons.rectangle_3_offgrid_fill),
                  SizedBox(width: 20),
                  Text("Reminder"),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.block),
                  SizedBox(width: 20),
                  Text("Block numbers"),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.voicemail_outlined),
                  SizedBox(width: 20),
                  Text("Rout to voicemail"),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.link),
                  SizedBox(width: 20),
                  Text("View linked contacts"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

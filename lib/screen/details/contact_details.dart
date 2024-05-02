import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/screen/home/provider/contact_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails({super.key});

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  ContactProvider? providerR;
  ContactProvider? providerW;

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;
    providerR = context.read<ContactProvider>();
    providerW = context.watch<ContactProvider>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: () {
              Share.share(
                  "${providerR!.contactList[index].name}\n${providerR!.contactList[index].chat}\n${providerR!.contactList[index].mobile}");
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
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
              Text("${providerR!.contactList[index].name}",
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.indigo.shade100),
                    ),
                    onPressed: () async {
                      String call =
                          "tel:+91${providerR!.contactList[index].mobile}";
                      await launchUrl(Uri.parse(call));
                    },
                    icon: const Icon(Icons.local_phone_outlined),
                  ),
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.indigo.shade100),
                    ),
                    onPressed: () async {
                      String sms =
                          "sms:+91${providerR!.contactList[index].mobile}";
                      await launchUrl(Uri.parse(sms));
                    },
                    icon: const Icon(Icons.textsms_outlined),
                  ),
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.indigo.shade100),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.videocam_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 120,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.topLeft,
                width: MediaQuery.sizeOf(context).width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contact Info",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.local_phone_outlined),
                        Flexible(
                          child: ListTile(
                            title: Text(
                              "+91 ${providerR!.contactList[index].mobile}",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            subtitle: Text(
                              "Phone",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        ),
                        const Icon(Icons.videocam_outlined),
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(Icons.textsms_outlined),
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
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Connected Apps",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
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
                        Text(
                          "WhatsApp",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Contact Settings",
                    style: Theme.of(context).textTheme.labelSmall),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.photo_album),
                  const SizedBox(width: 20),
                  Text(
                    "Reminder",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.block),
                  const SizedBox(width: 20),
                  Text(
                    "Block numbers",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.voicemail_outlined),
                  const SizedBox(width: 20),
                  Text(
                    "Rout to voicemail",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.link),
                  const SizedBox(width: 20),
                  Text(
                    "View linked contacts",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

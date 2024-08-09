import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter/screen/home/provider/contact_provider.dart';
import 'package:platform_converter/utils/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home/model/contact_model.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails({super.key});

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  ContactProvider? providerR;
  ContactProvider? providerW;
  GlobalKey<FormState> formkey = GlobalKey();

  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtChat = TextEditingController();

  String? path;

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;
    providerR = context.read<ContactProvider>();
    providerW = context.watch<ContactProvider>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              alert(context, index);
            },
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
                    onPressed: () async {
                      String call =
                          "tel:+91${providerR!.contactList[index].mobile}";
                      await launchUrl(Uri.parse(call));
                    },
                    icon: const Icon(Icons.local_phone_outlined),
                  ),
                  IconButton(
                    onPressed: () async {
                      String sms =
                          "sms:+91${providerR!.contactList[index].mobile}";
                      await launchUrl(Uri.parse(sms));
                    },
                    icon: const Icon(Icons.textsms_outlined),
                  ),
                  IconButton(
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

  void alert(BuildContext context, int data) {
    txtName.text = providerR!.contactList[data].name!;
    txtPhone.text = providerR!.contactList[data].mobile!;
    txtChat.text = providerR!.contactList[data].chat!;

    path = providerR!.contactList[data].image;

    showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Form(
              key: formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        path == null
                            ? CircleAvatar(
                                backgroundColor: Colors.grey.shade400,
                                maxRadius: 60,
                                child: InkWell(
                                  onTap: () async {
                                    ImagePicker picker = ImagePicker();
                                    XFile? image = await picker.pickImage(
                                        source: ImageSource.gallery);
                                    setState(
                                      () {
                                        path = image!.path;
                                      },
                                    );
                                  },
                                  child: const Icon(
                                    Icons.image_search,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(File(path!)),
                                maxRadius: 60,
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            icon: Icon(
                              Icons.perm_identity_outlined,
                              size: 30,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            hintText: "Full Name",
                            hintStyle: Theme.of(context).textTheme.labelSmall),
                        controller: txtName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          icon: Icon(
                            Icons.call,
                            size: 30,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          hintText: "Phone Number",
                          hintStyle: Theme.of(context).textTheme.labelSmall,
                        ),
                        controller: txtPhone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Mobile Number";
                          } else if (value.length != 10) {
                            return "please enter the 10 digits";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            icon: Icon(
                              Icons.chat,
                              size: 30,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            hintText: "Chat Conversation",
                            hintStyle: Theme.of(context).textTheme.labelSmall),
                        controller: txtChat,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        onPressed: () async {
                          DateTime? d1 = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2050));

                          providerR!.selectedData(d1!);
                        },
                        label: Text(
                            "${providerW!.changeDate.day}/${providerW!.changeDate.month}/${providerW!.changeDate.year}"),
                        icon: const Icon(Icons.calendar_month),
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          TimeOfDay? t1 = await showTimePicker(
                              context: context,
                              initialTime: providerW!.changeTime);
                          providerR!.selectedTime(t1!);
                        },
                        label: Text(
                            "${providerW!.changeTime.hour}:${providerW!.changeTime.minute}"),
                        icon: const Icon(Icons.watch_later_outlined),
                      ),
                    ],
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          if (path != null) {
                            ContactModel c1 = ContactModel(
                              name: txtName.text,
                              mobile: txtPhone.text,
                              chat: txtChat.text,
                              image: path,
                              date: providerW!.changeDate,
                              time: providerW!.changeTime,
                            );
                            providerR!.contactList[data] = c1;
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please Enter The Details"),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text("Save"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter/screen/home/model/contact_model.dart';
import 'package:platform_converter/screen/home/provider/contact_provider.dart';
import 'package:platform_converter/utils/theme_provider.dart';
import 'package:provider/provider.dart';

class IosAddNewContact extends StatefulWidget {
  const IosAddNewContact({super.key});

  @override
  State<IosAddNewContact> createState() => _IosAddNewContactState();
}

class _IosAddNewContactState extends State<IosAddNewContact> {
  ContactProvider? providerR;
  ContactProvider? providerW;
  ThemeProvider? providerTR;
  ThemeProvider? providerTW;
  String? path;
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtChat = TextEditingController();
  TextEditingController txtPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    providerR = context.read<ContactProvider>();
    providerW = context.watch<ContactProvider>();
    providerTR = context.read<ThemeProvider>();
    providerTW = context.watch<ThemeProvider>();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Contact App'),
        trailing: CupertinoSwitch(
          value: providerTW!.isAndroid,
          onChanged: (value) {
            providerTR!.changePlatform();
          },
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
          child: Consumer<ContactProvider>(
            builder: (context, value, child) => Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  path == null
                      ? CircleAvatar(
                          backgroundColor: Colors.grey.shade400,
                          maxRadius: 60,
                          child: GestureDetector(
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
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(CupertinoIcons.person),
                      Flexible(
                        child: CupertinoTextFormFieldRow(
                          controller: txtName,
                          keyboardType: TextInputType.name,
                          placeholder: 'Enter The Name',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Name";
                            }
                            return null;
                          },
                          decoration: BoxDecoration(border: Border.all()),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(CupertinoIcons.phone),
                      Flexible(
                        child: CupertinoTextFormFieldRow(
                          controller: txtPhone,
                          keyboardType: TextInputType.phone,
                          placeholder: 'Enter Mobile Number',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Mobile";
                            }
                            return null;
                          },
                          decoration: BoxDecoration(border: Border.all()),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(CupertinoIcons.chat_bubble),
                      Flexible(
                        child: CupertinoTextFormFieldRow(
                          controller: txtChat,
                          keyboardType: TextInputType.text,
                          placeholder: 'Enter MSG',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Send A MSG";
                            }
                            return null;
                          },
                          decoration: BoxDecoration(border: Border.all()),
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CupertinoButton(
                        child: const Icon(CupertinoIcons.calendar),
                        onPressed: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 200,
                                child: CupertinoDatePicker(
                                  backgroundColor: Colors.white,
                                  onDateTimeChanged: (value) {
                                    context.read<ContactProvider>().changeDate;
                                  },
                                  mode: CupertinoDatePickerMode.date,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      CupertinoButton(
                        child: const Icon(CupertinoIcons.time),
                        onPressed: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 200,
                                child: CupertinoDatePicker(
                                  backgroundColor: Colors.white,
                                  onDateTimeChanged: (value) {
                                    context.read<ContactProvider>().changeDate;
                                  },
                                  mode: CupertinoDatePickerMode.time,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CupertinoButton(
                    child: const Text("Save"),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        if (path != null) {
                          ContactModel c1 = ContactModel(
                            name: txtName.text,
                            image: path,
                            mobile: txtPhone.text,
                            chat: txtChat.text,
                            date: providerR!.changeDate,
                            time: providerR!.changeTime,
                          );
                          context.read<ContactProvider>().addContact(c1);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please Enter The Details"),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

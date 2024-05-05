import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter/utils/shared_pref.dart';
import 'package:platform_converter/utils/theme_provider.dart';
import 'package:provider/provider.dart';
import '../model/contact_model.dart';
import '../provider/contact_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String? path;
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtBio = TextEditingController();
  ThemeProvider? providerR;
  ThemeProvider? providerW;

  String? phone, work, noLabel, office;

  @override
  Widget build(BuildContext context) {
    providerR = context.read<ThemeProvider>();
    providerW = context.watch<ThemeProvider>();
    return Form(
      key: formkey,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.person,
            ),
            title: const Text("Profile"),
            subtitle: const Text("Update Profile Data"),
            trailing: Switch(
              value: providerR!.showProfile,
              onChanged: (value) {
                providerR!.profileShow(value);
              },
            ),
          ),
          (providerR!.showProfile)
              ? Column(
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
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.82,
                            child: Flexible(
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(
                                      Icons.perm_identity_outlined,
                                      size: 30,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    hintText: "Full Name",
                                    hintStyle:
                                        Theme.of(context).textTheme.labelSmall),
                                controller: txtName,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Name is required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.82,
                            child: Flexible(
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(
                                      Icons.integration_instructions_rounded,
                                      size: 30,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    hintText: "Bio",
                                    hintStyle:
                                        Theme.of(context).textTheme.labelSmall),
                                controller: txtBio,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(),
          const Divider(
            endIndent: 10,
            indent: 10,
          ),
          ListTile(
            leading: const Icon(
              Icons.wb_sunny_outlined,
            ),
            title: const Text("Theme"),
            subtitle: const Text("Change Theme"),
            trailing: Switch(
              value: providerW!.themeMode,
              onChanged: (value) {
                setThemeData(value);
                providerR!.setTheme();
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  if (path != null) {
                    ContactModel c1 = ContactModel(
                      name: txtName.text,
                      image: path,
                      chat: txtBio.text,
                    );
                    formkey.currentState!.save();
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
              child: const Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter/utils/shared_pref.dart';
import 'package:platform_converter/utils/theme_provider.dart';
import 'package:provider/provider.dart';

import '../home/model/contact_model.dart';
import '../home/provider/contact_provider.dart';

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

  ContactProvider? providerCR;
  ContactProvider? providerWR;

  @override
  void initState() {
    super.initState();
    context.read<ContactProvider>().selectedImage();
    context.read<ContactProvider>().setUserBio();
    context.read<ContactProvider>().setUserName();
    txtName.text = context.read<ContactProvider>().userName;
    txtBio.text = context.read<ContactProvider>().userBio;
  }

  @override
  Widget build(BuildContext context) {
    providerR = context.read<ThemeProvider>();
    providerW = context.watch<ThemeProvider>();
    providerCR = context.read<ContactProvider>();
    providerWR = context.watch<ContactProvider>();
    return Column(
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
              providerR!.selectedProfile();
            },
          ),
        ),
        providerW!.showProfile
            ? Form(
                key: formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        ImagePicker picker = ImagePicker();
                        XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        SharedHelper.helper.setUserImage(image!.path);
                        providerCR!.selectedImage();
                      },
                      child: providerWR!.image.isEmpty
                          ? CircleAvatar(
                              backgroundColor: Colors.grey.shade400,
                              maxRadius: 60,
                              child: const Icon(
                                Icons.image_search,
                                size: 40,
                                color: Colors.white,
                              ),
                            )
                          : CircleAvatar(
                              maxRadius: 60,
                              backgroundImage: FileImage(
                                File(providerWR!.image),
                              ),
                            ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          TextFormField(
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
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
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
                        ],
                      ),
                    ),
                  ],
                ),
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
              SharedHelper.helper.setThemeData(value);
              providerR!.setTheme();
            },
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              if (formkey.currentState!.validate()) {
                SharedHelper.helper.setUserName(txtName.text);
                SharedHelper.helper.setUserBio(txtBio.text);
                providerCR!.setUserName();
                providerCR!.setUserBio();
              }
            },
            child: const Text("Save"),
          ),
        ),
      ],
    );
  }
}

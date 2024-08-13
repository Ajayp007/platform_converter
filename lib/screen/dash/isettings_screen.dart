import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter/utils/shared_pref.dart';
import 'package:platform_converter/utils/theme_provider.dart';
import 'package:provider/provider.dart';

import '../home/model/contact_model.dart';
import '../home/provider/contact_provider.dart';

class ISettingScreen extends StatefulWidget {
  const ISettingScreen({super.key});

  @override
  State<ISettingScreen> createState() => _ISettingScreenState();
}

class _ISettingScreenState extends State<ISettingScreen> {
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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                CupertinoListTile(
                  leading: const Icon(
                    CupertinoIcons.person,
                  ),
                  title: const Text("Profile"),
                  subtitle: const Text("Update Profile Data"),
                  trailing: CupertinoSwitch(
                    value: providerR!.showProfile,
                    onChanged: (value) {
                      providerR!.selectedProfile();
                    },
                  ),
                ),
                providerR!.showProfile
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              ImagePicker picker = ImagePicker();
                              XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);
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
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                CupertinoTextFormFieldRow(
                                  controller: txtName,
                                  keyboardType: TextInputType.name,
                                  placeholder: 'Enter The Name',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please Enter Name";
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CupertinoTextFormFieldRow(
                                  controller: txtBio,
                                  keyboardType: TextInputType.name,
                                  placeholder: 'Enter The Bio',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please Enter Bio";
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Container(),
                Divider(
                  color: providerW!.themeMode ? Colors.black : Colors.white,
                  endIndent: 10,
                  indent: 10,
                ),
                CupertinoListTile(
                  leading: const Icon(
                    CupertinoIcons.sun_max,
                  ),
                  title: const Text("Theme"),
                  subtitle: const Text("Change Theme"),
                  trailing: CupertinoSwitch(
                    value: providerW!.themeMode,
                    onChanged: (value) {
                      SharedHelper.helper.setThemeData(value);
                      providerR!.setTheme();
                    },
                  ),
                ),
                Center(
                  child: CupertinoButton(
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
            ),
          ),
        ),
      ),
    );
  }
}

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
                                            CupertinoIcons.photo,
                                            size: 40,
                                          ),
                                        ),
                                      )
                                    : CircleAvatar(
                                        backgroundImage: FileImage(
                                          File(path!),
                                        ),
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
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.82,
                                  child: Flexible(
                                    child: CupertinoTextFormFieldRow(
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
                CupertinoListTile(
                  leading: const Icon(
                    CupertinoIcons.sun_max,
                  ),
                  title: const Text("Theme"),
                  subtitle: const Text("Change Theme"),
                  trailing: CupertinoSwitch(
                    value: providerW!.themeMode,
                    onChanged: (value) {
                      setThemeData(value);
                      providerR!.setTheme();
                    },
                  ),
                ),
                Center(
                  child: CupertinoButton(
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
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../home/model/contact_model.dart';
import '../home/provider/contact_provider.dart';

class AddNewContact extends StatefulWidget {
  const AddNewContact({super.key});

  @override
  State<AddNewContact> createState() => _AddNewContactState();
}

class _AddNewContactState extends State<AddNewContact> {
  String? path;
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtphone = TextEditingController();
  ContactProvider? providerR;
  ContactProvider? providerW;

  String? phone, work, noLabel, office;

  @override
  Widget build(BuildContext context) {
    providerR = context.read<ContactProvider>();
    providerW = context.watch<ContactProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
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
                                border: const OutlineInputBorder(),
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
                            controller: txtphone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Mobile Number";
                              } else if (value.length != 10) {
                                return "please enter the 10 digits";
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
                                border: const OutlineInputBorder(),
                                icon: Icon(
                                  Icons.chat,
                                  size: 30,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                hintText: "Chat Conversation",
                                hintStyle:
                                    Theme.of(context).textTheme.labelSmall),
                            controller: txtemail,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: () async {
                        DateTime? d1 = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050));

                        providerR!.seletedData(d1!);
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
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        if (path != null) {
                          ContactModel c1 = ContactModel(
                            name: txtName.text,
                            image: path,
                            mobile: txtphone.text,
                            chat: txtemail.text,
                            date: providerW!.changeDate,
                            time: providerW!.changeTime,
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

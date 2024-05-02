import 'package:flutter/material.dart';
import 'package:platform_converter/screen/addnew/add_new_contact.dart';
import 'package:platform_converter/screen/home/multiscreen/setting_screen.dart';
import 'package:provider/provider.dart';
import '../../../utils/theme_provider.dart';
import '../multiscreen/call_screen.dart';
import '../multiscreen/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ThemeProvider? providerR;
  ThemeProvider? providerW;

  @override
  Widget build(BuildContext context) {
    providerR = context.read<ThemeProvider>();
    providerW = context.watch<ThemeProvider>();

    return DefaultTabController(
      initialIndex: providerW!.pageIndex,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Contacts"),
          actions: [
            Switch(
              value: providerW!.isAndroid,
              onChanged: (value) {
                providerR!.changePlatform();
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person_add_alt)),
              Tab(text: "Call"),
              Tab(text: "Chat"),
              Tab(text: "Settings"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AddNewContact(),
            CallScreen(),
            ChatScreen(),
            SettingScreen(),
          ],
        ),
      ),
    );
  }
}

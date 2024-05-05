import 'package:flutter/cupertino.dart';
import 'package:platform_converter/screen/addnew/ios_add_new_contact.dart';
import 'package:provider/provider.dart';

import '../../../utils/theme_provider.dart';
import '../../dash/icall_screen.dart';
import '../../dash/ichat_screen.dart';
import '../../dash/isettings_screen.dart';

class IHomeScreen extends StatefulWidget {
  const IHomeScreen({super.key});

  @override
  State<IHomeScreen> createState() => _IHomeScreenState();
}

class _IHomeScreenState extends State<IHomeScreen> {
  ThemeProvider? providerR;
  ThemeProvider? providerW;

  @override
  Widget build(BuildContext context) {
    providerR = context.read<ThemeProvider>();
    providerW = context.watch<ThemeProvider>();

    List l1 =[
      const IosAddNewContact(),
      const ICallScreen(),
      const IChatScreen(),
      const ISettingScreen(),
    ];

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: providerR!.pageIndex,
        onTap: (value) {
          int index = value;
          providerR!.changeIndex(index: index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_add),
            label: 'Add New',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.phone),
            label: 'Call',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_text),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return l1[providerR!.pageIndex];
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../utils/theme_provider.dart';

class ISettingScreen extends StatefulWidget {
  const ISettingScreen({super.key});

  @override
  State<ISettingScreen> createState() => _ISettingScreenState();
}

class _ISettingScreenState extends State<ISettingScreen> {
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
      child: const Center(),
    );
  }
}

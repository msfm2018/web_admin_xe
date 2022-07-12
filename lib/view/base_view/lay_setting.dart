import 'package:flutter/material.dart';

class LaySetting extends StatefulWidget {
  const LaySetting({Key? key}) : super(key: key);

  @override
  State<LaySetting> createState() => _LaySettingState();
}

class _LaySettingState extends State<LaySetting> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          DrawerHeader(
            child: Text('Text(S.of(context).mySettings)'),
            // decoration: BoxDecoration(
            //   color: Get.theme.primaryColor,
            // ),
          ),
          ListTile(
            title: Text('S.of(context).language'),
            // trailing: LangSwitch(),
          ),
          Divider(thickness: 1),
          Divider(thickness: 1),
          ListTile(
            title: Text('Text(S.of(context).nightMode)'),
          ),
          Divider(thickness: 1),
        ],
      ),
    );
  }
}

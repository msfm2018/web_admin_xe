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
        children: const <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Text('头测试'),
          ),
          ListTile(
            title: Text(
              'body',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(Icons.wallet),
          ),
        ],
      ),
    );
  }
}

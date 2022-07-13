import 'package:flutter/material.dart';
import 'package:web_admin/view/base_view/left/left.dart';

import 'constans/constans.dart';
import 'view/base_view/lay_setting.dart';
import 'view/base_view/login.dart';
import 'view/base_view/right/right.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State {
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RightState> layoutCenterKey = GlobalKey<RightState>();

  @override
  void initState() {
    super.initState();
  }

  get _drawer => Drawer(
        child: Center(
            child: Column(
          children: [
            DrawerHeader(
                child: Text(
              'header',
              style: TextStyle(color: Colors.white),
            )),
            Text(
              'This is Drawer',
              style: TextStyle(color: Colors.white),
            )
          ],
        )),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldStateKey,
      drawer: _drawer,
      endDrawer: const LaySetting(),
      body: Row(
        children: <Widget>[
          const Left(),
          const VerticalDivider(
            width: 2,
            color: Colors.black12,
            thickness: 2,
          ),
          Right(key: layoutCenterKey),
        ],
      ),
      appBar: getAppBar(),
    );
  }

  getAppBar() {
    return AppBar(
      backgroundColor: AppTheme.dismissibleBackground,
      automaticallyImplyLeading: false,
      leading: Tooltip(
          message: '主页',
          child: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              scaffoldStateKey.currentState!.openDrawer();
            },
          )),
      title: Row(children: const [
        Text('后台管理框架'),
      ]),
      actions: <Widget>[
        Tooltip(
          message: '设置',
          child: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              scaffoldStateKey.currentState!.openEndDrawer();
            },
          ),
        ),
        PopupMenuButton(
          onSelected: (dynamic v) {
            switch (v) {
              case 'exit':
                Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => const Login()),
                  ModalRoute.withName('/'),
                );
                break;
            }
          },
          itemBuilder: (context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'exit',
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('退出'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:web_admin/tree_core/left_items/left.dart';

import 'login.dart';
import 'tree_core/right_inspect/right.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State {
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  get _drawer => Drawer(
        child: Center(
            child: Column(
          children: const [
            Text('data'),
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
  Drawer _endDrawer() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldStateKey,
      drawer: _drawer,
      endDrawer: _endDrawer(),
      body: const TreeWidget(),
      appBar: getAppBar(),
    );
  }

  getAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 202, 219, 228),
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
        Text('后台管理框架', style: TextStyle(color: Colors.white)),
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
                //首先清除缓存数据
                //  退出到登录窗口
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

class TreeWidget extends StatelessWidget {
  const TreeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        Left(),
        VerticalDivider(
          width: 2,
          color: Colors.black12,
          thickness: 2,
        ),
        Right(),
      ],
    );
  }
}

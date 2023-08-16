import 'package:flutter/material.dart';

import 'login.dart';
import 'tree_core/tree.dart';
import 'tree_core/left_items/left.dart';

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

  get _drawer => LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // 平板屏幕，显示两个页面
            return const Drawer(
              child: Center(
                  child: Column(
                children: [
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
          } else {
            // 手机屏幕，只显示一个页面
            return const Drawer(child: Left());
          }
        },
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
      backgroundColor: const Color.fromARGB(255, 117, 155, 119),
      automaticallyImplyLeading: false,
      leading: Tooltip(
          message: '主页',
          child: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              scaffoldStateKey.currentState!.openDrawer();
            },
          )),
      title: const Row(children: [
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
                  MaterialPageRoute<void>(builder: (BuildContext context) => const Login()),
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

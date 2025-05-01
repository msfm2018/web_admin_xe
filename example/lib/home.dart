import 'package:flutter/material.dart';
import 'package:simple_tree/simple_tree.dart';

import 'tree_config/menu_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State {
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    //添加 第一处
    // Config.style = const TextStyle(fontSize: 20.0, color: Colors.blue);
    Config.init(myAppPages);
  }

  @override
  void dispose() {
    Config.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldStateKey,
      appBar: getAppBar(),
      body: TreeWidget(data: data),//添加 第二处
    );
  }

  getAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 117, 155, 119),
      automaticallyImplyLeading: false,
      title: const Text('后台管理框架', style: TextStyle(color: Colors.white)),
    );
  }
}

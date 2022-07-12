///控制器
import 'dart:async';
import 'package:flutter/material.dart';

class Testxx extends StatefulWidget {
  const Testxx({Key? key}) : super(key: key);

  @override
  State<Testxx> createState() => _TestxxState();
}

class _TestxxState extends State<Testxx> {
  @override
  Widget build(BuildContext context) {
    return TextField();
  }
}

class Test2 extends StatefulWidget {
  const Test2({Key? key}) : super(key: key);

  @override
  State<Test2> createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              print('移除前');
              print(Mgr().openedTabPageList.toString());
              Mgr().openedTabPageList.remove('北京');
              print('移除后');
              print(Mgr().openedTabPageList.toString());
              Mgr().idControler.add('北京');
            },
            child: Text('准备删除北京'))
      ],
    );
  }
}

///树的管理者
class Mgr extends State {
  Mgr._() {
    _instance = this;

    /// 配对数据
    vView = <String, Widget>{};

    openedTabPageList = <String>[];

    ///
    idControler = StreamController.broadcast();

    vView.putIfAbsent('北京', () => Testxx());
    vView.putIfAbsent('上海', () => Test2());
    vView.putIfAbsent('天津', () => Text('天津页面'));
    vView.putIfAbsent('重庆', () => Text('重庆页面'));
  }

  static Mgr? _instance;
  factory Mgr() {
    return _instance ??= Mgr._();
  }

  static Mgr get instance => _getInstance();

  static Mgr _getInstance() {
    return _instance ?? Mgr._();
  }

  bool isAllExpanded = false;

  late StreamController<String> idControler;

  late List<String> openedTabPageList;

  ///页面临时pageView
  late Map<String, Widget> vView;

  @override
  Widget build(Object context) {
    return Container();
  }

  @override
  void dispose() {
    idControler.close();
    super.dispose();
  }
}

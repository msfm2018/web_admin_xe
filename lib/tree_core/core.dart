///控制器
import 'dart:async';
import 'package:flutter/material.dart';

import '../tree_config/config.dart';

typedef Wb<T> = Widget Function(T);

///树的管理者
class Core extends State {
  Core._() {
    _instance = this;

    /// 配对数据
    pages = <String, Widget>{};

    openedPageList = <String>[];

    ///
    pageControlerAction = StreamController.broadcast();
    btnControlerAction = StreamController.broadcast();
    itemControlerAction = StreamController.broadcast();
    Config.init();
  }

  static Core? _instance;
  factory Core() {
    return _instance ??= Core._();
  }

  static Core get instance => _getInstance();

  static Core _getInstance() {
    return _instance ?? Core._();
  }

//一共需要通知的三个地方 tree  右侧panel  button列表

// 右侧页面发生变化
  void notifyPage(String n) {
    pageControlerAction.add(n);
  }

// 左侧树发生变化
  void notifyItem(String n) {
    itemControlerAction.add(n);
  }

//标题栏按钮发生变化
  void notifyBtns(String n) {
    btnControlerAction.add(n);
  }

  bool isAllExpanded = false;
  var selectedNodeName = '';
  var selectedColor = Colors.blue[200];

  //3个地方需要update通知
  late StreamController<String> pageControlerAction;

  late StreamController<String> btnControlerAction;
  late StreamController<String> itemControlerAction;

  late List<String> openedPageList;

  var rightPanelColor = Colors.white;
  var toolbarColor = const Color(0xFFFEFEFE);
  var toolbarHeight = 40.0;

  ///----------------------------------------------------
  ///页面配置
  late Map<String, Widget> pages;

  ///内存节点快捷按钮
  // late Map<String, Widget> pagesAction;

  ///------------------------------------------------------
  @override
  Widget build(Object context) {
    return Container();
  }

  @override
  void dispose() {
    pageControlerAction.close();
    btnControlerAction.close();
    itemControlerAction.close();
    super.dispose();
  }
}

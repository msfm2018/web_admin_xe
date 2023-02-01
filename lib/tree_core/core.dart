///控制器
import 'dart:async';
import 'package:flutter/material.dart';

import '../view_config/config.dart';

typedef Wb<T> = Widget Function(T);

///树的管理者
class Core extends State {
  Core._() {
    _instance = this;

    /// 配对数据
    pages = <String, Widget>{};
    // pagesAction = <String, Widget>{};

    openedTabPageList = <String>[];

    ///
    idControler = StreamController.broadcast();
    idControlerAction = StreamController.broadcast();
    btnControler = StreamController.broadcast();
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

  bool isAllExpanded = false;
  var selectedNodeName = '';
  var selectedColor = Colors.blue[200];
  late StreamController<String> idControler;

  late StreamController<String> idControlerAction;
  late StreamController<String> btnControler;

  late List<String> openedTabPageList;

  var rightPanelColor = Colors.white;
  var toolbarColor = const Color(0xFFFEFEFE);
  var toolbarHeight = 40.0;

  ///----------------------------------------------------
  ///页面临时pageView
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
    idControler.close();
    super.dispose();
  }
}

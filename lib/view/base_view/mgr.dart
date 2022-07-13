///控制器
import 'dart:async';
import 'package:flutter/material.dart';

import '../../view_config/config.dart';

typedef Wb<T> = Widget Function(T);

///树的管理者
class Mgr extends State {
  Mgr._() {
    _instance = this;

    /// 配对数据
    vView = <String, Widget>{};
    vViewAction = <String, Widget>{};

    openedTabPageList = <String>[];

    ///
    idControler = StreamController.broadcast();
    idControlerAction = StreamController.broadcast();
    colorControler = StreamController.broadcast();
    Config.init();
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
  var selectedNodeName = '';
  var selectedColor = Colors.blue[200];
  late StreamController<String> idControler;

  late StreamController<String> idControlerAction;
  late StreamController<String> colorControler;

  late List<String> openedTabPageList;

  var rightPanelColor = Colors.white;
  var toolbarColor = const Color(0xFFFEFEFE);
  var toolbarHeight = 40.0;

  ///----------------------------------------------------
  ///页面临时pageView
  late Map<String, Widget> vView;

  ///内存节点快捷按钮
  late Map<String, Widget> vViewAction;

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

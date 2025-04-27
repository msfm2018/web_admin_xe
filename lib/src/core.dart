import 'dart:async';
import 'package:flutter/material.dart';

import 'page_info.dart';

typedef Wb<T> = Widget Function(T);

//树对应的 页面配置

class Config {
  static TextStyle? _style;

  // 默认样式
  static final TextStyle _defaultStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: const Color.fromARGB(129, 19, 9, 9));

  static TextStyle get style => _style ?? _defaultStyle;

  // Setter：外部可以设置自定义样式
  static set style(TextStyle? newStyle) {
    _style = newStyle;
  }

  static init(List<PageInfo> initialPages) {
    for (var element in initialPages) {
      Core.instance.pageMap.putIfAbsent(element.name, () => element);
    }
  }

  static void dispose() {
    Core.instance.dispose();
  }
}

class Core {
  Core._() {
    _instance = this;
    pageMap = <String, PageInfo>{};
    pageControllerAction = StreamController<String>.broadcast();
    btnControllerAction = StreamController<String>.broadcast();
    itemControllerAction = StreamController<String>.broadcast();
  }

  static Core? _instance;
  factory Core() => _instance ??= Core._();
  static Core get instance => _getInstance();
  static Core _getInstance() => _instance ?? Core._();

  late StreamController<String> pageControllerAction;
  late StreamController<String> btnControllerAction;
  late StreamController<String> itemControllerAction;

  bool isAllExpanded = false;
  String selectedNodeName = '';
  Color? selectedColor = Colors.blue[200];

  Map<String, PageInfo> pageMap = <String, PageInfo>{};

  void notifyPage(String n) {
    pageControllerAction.add(n);
  }

  void notifyItem(String n) {
    itemControllerAction.add(n);
  }

  void notifyBtns(String n) {
    btnControllerAction.add(n);
  }

  // 新增：用于尝试清理 widget 的方法
  // void _disposePageWidget(Widget? widget) {
  //   if (widget is StatefulWidget) {
  //     final state = widget.createState();
  //     if (state is State) {
  //       state.dispose();
  //     }
  //   }
  //   // 对于 StatelessWidget，通常不需要显式 dispose
  // }

  void dispose() {
    pageControllerAction.close();
    btnControllerAction.close();
    itemControllerAction.close();
    // 清理所有 PageInfo 中的 widget (在 Core 销毁时)
    // for (var pageInfo in pageMap.values) {
    //   // _disposePageWidget(pageInfo.widget);
    // }
    _instance = null; // 如果 Core 也可以被销毁
  }
}

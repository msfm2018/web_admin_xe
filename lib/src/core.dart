import 'package:flutter/material.dart';
import 'package:rxflare/rxflare.dart';
import 'page_info.dart';

// Core：统一控制器 + 样式 + 页面管理
class Core {
  Core._() {
    _instance = this;
    pageMap = RxState<Map<int, PageInfo>>(<int, PageInfo>{});
    pageAction = RxState<int>(-1);
    btnAction = RxState<int>(-1);
    itemAction = RxState<int>(-1);
    selectedNodeIndex = RxState<int>(-1); // 初始化 selectedNodeIndex
  }

  static Core? _instance;
  factory Core() => _instance ??= Core._();
  static Core get instance => _getInstance();
  static Core _getInstance() => _instance ?? Core._();

  /// 状态管理 (using RxState)
  late final RxState<int> pageAction;
  late final RxState<int> btnAction;
  late final RxState<int> itemAction;
  late final RxState<Map<int, PageInfo>> pageMap;
  late final RxState<int> selectedNodeIndex; // 使用 RxState

  /// 页面管理
  Map<int, PageInfo> get pageMapv => pageMap.value;

  Color? selectedColor = Colors.blue[200];

  /// 状态辅助
  bool isAllExpanded = false;

  /// 样式配置
  TextStyle? _style;
  static final TextStyle _defaultStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: const Color.fromARGB(129, 19, 9, 9));

  TextStyle get style => _style ?? _defaultStyle;
  set style(TextStyle? newStyle) => _style = newStyle;

  /// 初始化页面
  void initPages(List<PageInfo> initialPages) {
    final newMap = <int, PageInfo>{};
    for (var element in initialPages) {
      newMap.putIfAbsent(element.index, () => element);
    }
    pageMap.value = newMap;
  }

  /// 更新 pageMap 中的单个 PageInfo
  void updatePageInfo(int index, PageInfo newInfo) {
    final currentMap = Map<int, PageInfo>.from(pageMap.value);
    currentMap[index] = newInfo;
    pageMap.value = currentMap;
  }

  /// 移除 pageMap 中的 PageInfo
  void removePageInfo(int index) {
    final currentMap = Map<int, PageInfo>.from(pageMap.value);
    currentMap.remove(index);
    pageMap.value = currentMap;
  }

  /// 页面通知
  void notifyPage(int n) {
    pageAction.value = n;
  }

  void notifyItem(int n) {
    itemAction.value = n;
  }

  void notifyBtns(int n) {
    btnAction.value = n;
  }

  /// 资源清理
  void dispose() {
    pageAction.dispose();
    btnAction.dispose();
    itemAction.dispose();
    pageMap.dispose();
    selectedNodeIndex.dispose(); // Dispose selectedNodeIndex
    _instance = null;
  }
}

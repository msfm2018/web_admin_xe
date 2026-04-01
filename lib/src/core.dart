import 'package:flutter/material.dart';
import 'package:rxflare/rxflare.dart';
import 'page_info.dart';

/// 1. 增强型枚举：将事件与具体的响应式状态绑定
enum CoreEvent {
  page,
  btn,
  item;

  /// 内部映射逻辑：根据类型返回 Core 中对应的 RxState
  RxState<int> getTarget(Core core) => switch (this) {
        CoreEvent.page => core.pageAction,
        CoreEvent.btn => core.btnAction,
        CoreEvent.item => core.itemAction,
      };
}

/// 2. Core 类：采用精简单例与统一状态管理
class Core {
  // 私有构造函数与单例
  Core._();
  static final Core instance = Core._();

// final toggleSidebar = false.obs;
  final isSidebarCollapsed = false.obs;
  final activePageKeys = <int>[].obs;

  final pageAction = (-1).obs;

  final btnAction = (-1).obs;

  final itemAction = (-1).obs;

  final pageMap = <int, PageInfo>{}.obs;

  final selectedNodeIndex = (-1).obs;

  // --- UI 样式与配置 ---
  Color? selectedColor = Colors.blue[200];
  bool isAllExpanded = false;
  TextStyle? _style;
  void toggleSidebar() {
    isSidebarCollapsed.value = !isSidebarCollapsed.value;
  }

  static const _defaultStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
    color: Color.fromARGB(129, 19, 9, 9),
  );

  TextStyle get style => _style ?? _defaultStyle;
  set style(TextStyle? newStyle) => _style = newStyle;

  void notify(CoreEvent type, int value) {
    type.getTarget(this).value = value;
  }

  void switchPage(int index) {
    if (index == -1) {
      print("Switching to default state (no page selected)");
      selectedNodeIndex.value = -1;
      return;
    }

    if (!activePageKeys.contains(index)) {
      activePageKeys.add(index);

      final page = pageMap.value[index];
      if (page != null) {
        updatePageInfo(index, page.copyWith(isActive: true));
      }
    }

    selectedNodeIndex.value = index;

    for (var event in CoreEvent.values) {
      notify(event, index);
    }
  }

  void initPages(Iterable<PageInfo> initialPages) {
    pageMap.value = {for (var p in initialPages) p.index: p};
    activePageKeys.value = [];
  }

// ==================== Core.dart 中替换 ====================

// Core.dart

  void openPage(int index) {
    switchPage(index);
  }

  void closePage(int index) {
    final page = pageMap.value[index];
    if (page == null) {
      return;
    }
    // 使用扩展方法移除（推荐）
    if (activePageKeys.value.contains(index)) {
      activePageKeys.value.remove(index); // 或直接 activePageKeys.remove(index); 如果你扩展了
      activePageKeys.refresh(); // 保险起见
    }
    // 更新页面状态
    updatePageInfo(index, page.copyWith(isActive: false));

    // print("======================================");
    // print("📄 Page 完整数据 (index: $index)：");
    // print("page.index        = ${page.index}");
    // print("page.title        = ${page.title}");
    // print("page.isActive     = ${page.isActive}");
    // print("page.builder      = ${page.builder}");
    // print("page 原始对象: $page");
    // print(selectedNodeIndex.value);
    // print(index);
    // 如果关闭的是当前选中页，则切换到最后一个
    if (selectedNodeIndex.value == index) {
      final next = activePageKeys.value.isNotEmpty ? activePageKeys.value.last : -1;
      switchPage(next);
    }
  }

  /// 更新页面：使用 Map.of 确保引用改变，从而触发 rxflare 刷新
  void updatePageInfo(int index, PageInfo newInfo) {
    pageMap.value = Map.of(pageMap.value)..[index] = newInfo;
  }

  /// 移除页面
  void removePageInfo(int index) {
    if (!pageMap.value.containsKey(index)) return;
    pageMap.value = Map.of(pageMap.value)..remove(index);
  }

  void selectNode(int index) => selectedNodeIndex.value = index;

  void dispose() {
    pageAction.dispose();
    btnAction.dispose();
    itemAction.dispose();
    pageMap.dispose();
    selectedNodeIndex.dispose();
  }
}

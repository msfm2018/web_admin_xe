import 'package:flutter/material.dart';
import 'package:rxflare/rxflare.dart';
import 'page_info.dart';

/// 核心事件枚举，用于将业务事件与具体的响应式状态进行绑定。
///
/// 通过 [getTarget] 方法，可以将不同的事件类型映射到 [Core] 中对应的 [RxState]。
enum CoreEvent {
  /// 页面切换事件
  page,

  /// 按钮点击事件
  btn,

  /// 列表项操作事件
  item;

  /// 根据当前枚举类型获取 [Core] 实例中对应的 [RxState<int>] 状态对象。
  RxState<int> getTarget(Core core) => switch (this) {
        CoreEvent.page => core.pageAction,
        CoreEvent.btn => core.btnAction,
        CoreEvent.item => core.itemAction,
      };
}

/// 全局单例管理类，负责插件的状态维护、页面逻辑切换及 UI 配置。
///
/// 采用了 `rxflare` 的响应式编程范式，所有以 `.obs` 结尾的变量均为可监听状态。
class Core {
  /// 私有构造函数，确保单例模式。
  Core._();

  /// 获取 [Core] 的全局唯一实例。
  static final Core instance = Core._();

  /// 侧边栏是否处于折叠状态。
  final isSidebarCollapsed = false.obs;

  /// 当前已打开并处于活动状态的页面索引列表（多标签页逻辑）。
  final activePageKeys = <int>[].obs;

  /// 响应式对象：记录页面动作的索引。
  final pageAction = (-1).obs;

  /// 响应式对象：记录按钮点击动作的索引。
  final btnAction = (-1).obs;

  /// 响应式对象：记录项目操作动作的索引。
  final itemAction = (-1).obs;

  /// 维护所有可用页面的映射表，Key 为页面索引，Value 为 [PageInfo]。
  final pageMap = <int, PageInfo>{}.obs;

  /// 当前在 UI 上处于选中状态的节点索引。
  final selectedNodeIndex = (-1).obs;

  // --- UI 样式与配置 ---

  /// 选中节点时的背景颜色。
  Color? selectedColor = Colors.blue[200];

  /// 是否默认展开树结构中的所有节点。
  bool isAllExpanded = false;

  /// 内部存储的文本样式。
  TextStyle? _style;

  /// 切换侧边栏的展开与收起状态。
  void toggleSidebar() {
    isSidebarCollapsed.value = !isSidebarCollapsed.value;
  }

  /// 默认的文本样式配置。
  static const _defaultStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
    color: Color.fromARGB(129, 19, 9, 9),
  );

  /// 获取当前使用的文本样式。如果未设置 [_style]，则返回默认样式。
  TextStyle get style => _style ?? _defaultStyle;

  /// 设置自定义的文本样式。
  set style(TextStyle? newStyle) => _style = newStyle;

  /// 发送通知以更新特定的响应式状态。
  ///
  /// [type] 为事件类型，[value] 为关联的索引值。
  void notify(CoreEvent type, int value) {
    type.getTarget(this).value = value;
  }

  /// 核心切换逻辑：跳转到指定索引的页面。
  ///
  /// 如果 [index] 为 -1，则重置选中状态。
  /// 如果页面尚未在 [activePageKeys] 中，则将其添加并激活。
  void switchPage(int index) {
    if (index == -1) {
      // print("Switching to default state (no page selected)");
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
    // 触发所有相关事件的通知
    for (var event in CoreEvent.values) {
      notify(event, index);
    }
  }

  /// 初始化页面数据。
  ///
  /// [initialPages] 为初始的页面信息集合。执行后将清空当前的 [activePageKeys]。
  void initPages(Iterable<PageInfo> initialPages) {
    pageMap.value = {for (var p in initialPages) p.index: p};
    activePageKeys.value = [];
  }

  /// 打开一个页面（对 [switchPage] 的封装）。

  void openPage(int index) {
    switchPage(index);
  }

  /// 关闭一个指定索引的页面。
  ///
  /// 如果关闭的是当前正在显示的页面，系统会自动切换到 [activePageKeys] 中的最后一个页面。
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

  /// 更新页面信息。
  ///
  /// 使用 [Map.of] 创建新实例以触发 `rxflare` 的响应式监听。
  void updatePageInfo(int index, PageInfo newInfo) {
    pageMap.value = Map.of(pageMap.value)..[index] = newInfo;
  }

  /// 从映射表中移除指定的页面信息。
  void removePageInfo(int index) {
    if (!pageMap.value.containsKey(index)) return;
    pageMap.value = Map.of(pageMap.value)..remove(index);
  }

  /// 直接选中一个节点索引，不触发页面切换逻辑。
  void selectNode(int index) => selectedNodeIndex.value = index;

  /// 销毁所有响应式对象，释放内存资源。
  void dispose() {
    pageAction.dispose();
    btnAction.dispose();
    itemAction.dispose();
    pageMap.dispose();
    selectedNodeIndex.dispose();
  }
}

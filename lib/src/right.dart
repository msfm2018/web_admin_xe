import 'package:flutter/material.dart';
import 'package:rxflare/rxflare.dart';
import 'page_info.dart';
import 'core.dart';

/// 右侧内容容器组件。
///
/// 该组件实现了典型的管理后台布局：
/// 1. **顶部工具栏 (Toolbar)**: 展示已打开页面的标签，支持点击切换和点击关闭。
/// 2. **主显示区 (Content Area)**: 渲染当前选中的页面，并内置了页面缓存机制以提升性能。
class Right extends StatefulWidget {
  /// 创建一个 [Right] 组件。
  const Right({super.key});

  @override
  State<Right> createState() => RightState();
}

/// [Right] 组件的状态管理类。
///
/// 负责维护页面缓存 [_pageCache] 以及标签栏的横向滚动控制。
class RightState extends State<Right> with TickerProviderStateMixin {
  /// 标签栏的滚动控制器。
  late ScrollController _scrollController2;

  /// 页面缓存映射表。
  ///
  /// Key 为页面索引，Value 为已构建的 Widget。
  /// 缓存机制确保了在切换标签时，页面状态（如滚动位置、输入内容）得以保留，避免重复触发 [PageInfo.builder]。
  final Map<int, Widget> _pageCache = {};

  @override
  void initState() {
    super.initState();
    _scrollController2 = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          // 渲染多标签导航栏
          toolbar(),
          // 渲染主内容区域，带有一致的边距和圆角装饰
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _visiblePage(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget container(text) => Container(
        alignment: Alignment.center,
        child: Text(text, style: const TextStyle(fontSize: 18)),
      );

  /// 构建当前可见的页面内容。
  ///
  /// 监听 [Core.pageAction] 和 [Core.selectedNodeIndex] 的变化。
  /// 如果没有选中任何节点（index == -1），则显示欢迎页面。
  Widget _visiblePage() {
    return Rx.custom(
      deps: [Core.instance.pageAction, Core.instance.selectedNodeIndex],
      builder: () {
        final selectedIndex = Core.instance.selectedNodeIndex.value;

        if (selectedIndex == -1) {
          _pageCache.clear();
          return _buildWelcomePage();
        }

        final page = Core.instance.pageMap.value[selectedIndex];
        if (page == null) {
          _pageCache.clear();
          return _buildWelcomePage();
        }
// 使用 putIfAbsent 确保每个页面只被 builder 构建一次
        return _pageCache.putIfAbsent(
          page.index,
          () => page.builder(),
        );
      },
    );
  }

  /// ================= 页面显示 =================

  /// 构建默认的欢迎页面。
  ///
  /// 当未打开任何标签页或初始进入系统时显示。
  Widget _buildWelcomePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha:0.05),
              shape: BoxShape.circle,
            ),
            child: const FlutterLogo(size: 80),
          ),
          const SizedBox(height: 24),
          const Text(
            "欢迎使用后台管理系统",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "请从左侧菜单选择功能开始工作",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建多标签工具栏。
  ///
  /// 这是一个响应式组件，当 [activePageKeys] 或选中状态改变时自动刷新。
  /// 内部包含一个可横向滚动的 [SingleChildScrollView] 以容纳多个标签。
  Widget toolbar() {
    return Rx.custom(
      deps: [
        Core.instance.activePageKeys,
        Core.instance.selectedNodeIndex,
        Core.instance.pageMap,
        Core.instance.isSidebarCollapsed,
      ],
      builder: () {
        final activePages = Core.instance.activePageKeys.value.map((k) => Core.instance.pageMap.value[k]).whereType<PageInfo>().toList();
        return Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade200),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController2,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: activePages.map((page) {
                      final isSelected = page.index == Core.instance.selectedNodeIndex.value;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => _handleSelection(page),
                            child: Container(
                              height: 42,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: isSelected ? Core.instance.selectedColor ?? Colors.blue[100] : Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected ? Colors.blue : Colors.grey[300]!,
                                  width: isSelected ? 1.5 : 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (page.icon != null)
                                    Icon(
                                      page.icon,
                                      size: 16,
                                      color: isSelected ? Colors.blue.shade600 : Colors.grey.shade600,
                                    ),
                                  if (page.icon != null) const SizedBox(width: 6),
                                  Text(page.title),
                                  const SizedBox(width: 12),
                                  InkWell(
                                    onTap: () => _handleIconButton(page),
                                    child: const Icon(Icons.close, size: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// ================= 事件 =================

  /// 处理标签选中事件。
  void _handleSelection(PageInfo page) {
    Core.instance.selectedNodeIndex.value = page.index;
    Core.instance.openPage(page.index);
  }

  /// 处理标签关闭事件。
  ///
  /// 会同步清理 [_pageCache] 中的对应页面实例。
  void _handleIconButton(PageInfo page) {
    // 1. 释放缓存
    _pageCache.remove(page.index);

    // 2. 关闭页面（统一走 Core 的方法）
    Core.instance.closePage(page.index);
  }

  /// ================= UI =================

  Widget text(text) => Text(
        text,
        style: const TextStyle(
          fontFamily: 'WorkSans',
          letterSpacing: 0.2,
          fontWeight: FontWeight.w400,
          color: Color(0xFF4A6572),
          fontSize: 14,
        ),
      );

  @override
  void dispose() {
    _scrollController2.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:rxflare/rxflare.dart';
import 'page_info.dart';
import 'core.dart';

class Right extends StatefulWidget {
  const Right({super.key});

  @override
  State<Right> createState() => RightState();
}

class RightState extends State<Right> with TickerProviderStateMixin {
  late ScrollController _scrollController2;

  /// 页面缓存（防止切换重建）
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
          toolbar(),
          // Expanded(child: _visiblePage()),
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
          )
        ],
      ),
    );
  }

  Widget container(text) => Container(
        alignment: Alignment.center,
        child: Text(text, style: const TextStyle(fontSize: 18)),
      );
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

        return _pageCache.putIfAbsent(
          page.index,
          () => page.builder(),
        );
      },
    );
  }

  /// ================= 页面显示 =================

// 优化欢迎页
  Widget _buildWelcomePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.05),
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

// 优化Right组件build

  Widget toolbar22() {
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
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController2,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: activePages.map((page) {
                      final isSelected = page.index == Core.instance.selectedNodeIndex.value;

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => _handleSelection(page),
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.blue.shade50 : Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(8),
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
                                  Text(
                                    page.title,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                      color: isSelected ? Colors.blue.shade700 : Colors.grey.shade700,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  InkWell(
                                    onTap: () => _handleIconButton(page),
                                    borderRadius: BorderRadius.circular(4),
                                    child: Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Colors.grey.shade600,
                                    ),
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

  /// 切换页面
  void _handleSelection(PageInfo page) {
    Core.instance.selectedNodeIndex.value = page.index;
    Core.instance.openPage(page.index);
  }

  /// 关闭页面
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

import 'package:flutter/material.dart';
import 'package:rxflare/rxflare.dart';
import '../simple_tree.dart';

/// 一个支持响应式布局的树形结构容器组件。
/// 
/// 该组件会根据屏幕宽度自动调整布局模式：
/// * **宽屏 (宽度 > 600px)**: 显示为包含 [TreeSidebar] 的双栏布局，支持动画折叠。
/// * **窄屏 (宽度 <= 600px)**: 侧边栏会自动转入 [Scaffold.drawer] 中，主体显示右侧内容。
class TreeWidget extends StatelessWidget {

  /// 树形结构的数据源列表。
  final List<TreeBase> data;
  /// 创建一个 [TreeWidget]。
  /// 
  /// [data] 必须不为空，用于渲染左侧或抽屉内的树形菜单。
  const TreeWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 判断是否为大屏幕环境
        final bool isLargeScreen = constraints.maxWidth > 600;
        if (isLargeScreen) {
          // 平板/桌面端模式：显示 Row 布局，左侧为 TreeSidebar，右侧为 Right
          return Row(
            children: [
              // 响应式侧边栏部分
              Rx.custom(
                deps: [Core.instance.isSidebarCollapsed],
                builder: () {
                  final collapsed = Core.instance.isSidebarCollapsed.value;
                  
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      // 提供横向展开/收起的平滑动画
                      return SizeTransition(
                        sizeFactor: animation,
                        axis: Axis.horizontal,
                        child: child,
                      );
                    },
                    child: collapsed
                        ? const SizedBox.shrink() 
                        : TreeSidebar(
                            key: const ValueKey("sidebar"),
                            data: data,
                          ),
                  );
                },
              ),
              // 响应式分隔线：仅在侧边栏展开时显示
              Rx.custom(
                deps: [Core.instance.isSidebarCollapsed],
                builder: () {
                  return Core.instance.isSidebarCollapsed.value ? const SizedBox.shrink() : const VerticalDivider(width: 2, thickness: 2);
                },
              ),
              // 右侧主内容区域
              Right(),
              // const Expanded(child: Right()),
            ],
          );
        } else {
          // 移动端模式：使用 Scaffold 配合 Drawer
          // 手机屏幕，显示右侧内容，并使用 Drawer 展示左侧树形菜单
          return Scaffold(
            appBar: AppBar(
              // title: const Text('Your App Title'),
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
            drawer: Drawer(
              child: TreeSidebar(data: data), // 将左侧菜单放入 Drawer
            ),
            body: const Row(
              children: [
                Expanded(child: Right()), // 确保右侧内容占据剩余空间
              ],
            ),
          );
        }

        // }
      },
    );
  }
}

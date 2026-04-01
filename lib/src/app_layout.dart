import 'package:flutter/material.dart';
import 'package:rxflare/rxflare.dart';
import '../simple_tree.dart';

class TreeWidget extends StatelessWidget {
  final List<TreeBase> data;
  const TreeWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // 平板屏幕，显示两个页面
          return Row(
            children: [
              Rx.custom(
                deps: [Core.instance.isSidebarCollapsed],
                builder: () {
                  final collapsed = Core.instance.isSidebarCollapsed.value;

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
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

              Rx.custom(
                deps: [Core.instance.isSidebarCollapsed],
                builder: () {
                  return Core.instance.isSidebarCollapsed.value ? const SizedBox.shrink() : const VerticalDivider(width: 2, thickness: 2);
                },
              ),
              Right()
              // const Expanded(child: Right()),
            ],
          );
        } else {

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

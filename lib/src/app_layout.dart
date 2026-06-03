import 'package:flutter/material.dart';
import 'package:rxflare/rxflare.dart';
import '../simple_tree.dart';

/// A responsive tree structure container widget.
///
/// This widget automatically adapts its layout based on screen width:
///
/// * **Large screens (width > 600px)**:
///   Displays a two-column layout with a [TreeSidebar] on the left
///   and main content on the right. The sidebar supports animated collapse.
///
/// * **Small screens (width <= 600px)**:
///   The sidebar is moved into a [Scaffold.drawer], while the main
///   content is displayed on the screen.
class TreeWidget extends StatelessWidget {
  /// The data source for the tree structure.
  ///
  /// This must not be empty and is used to render the tree menu
  /// in the sidebar or drawer.
  final List<TreeBase> data;

  /// Creates a [TreeWidget].
  const TreeWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Determine whether the screen is considered large
    return LayoutBuilder(
      builder: (context, constraints) {
        // 判断是否为大屏幕环境
        final bool isLargeScreen = constraints.maxWidth > 600;
        if (isLargeScreen) {
          // Tablet/Desktop layout:
          // Displays a Row with TreeSidebar on the left and Right content on the right
          return Row(
            children: [
              // Reactive sidebar section
              Rx.custom(
                deps: [Core.instance.isSidebarCollapsed],
                builder: () {
                  final collapsed = Core.instance.isSidebarCollapsed.value;

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      // Smooth horizontal expand/collapse animation
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
              // Divider (only visible when sidebar is expanded)
              Rx.custom(
                deps: [Core.instance.isSidebarCollapsed],
                builder: () {
                  return Core.instance.isSidebarCollapsed.value ? const SizedBox.shrink() : const VerticalDivider(width: 2, thickness: 2);
                },
              ),
              // Right-side main content
              Right(),
              // const Expanded(child: Right()),
            ],
          );
        } else {
          // Mobile layout:
          // Uses Scaffold + Drawer to display the tree menu
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
              child: TreeSidebar(data: data), // Tree menu in drawer
            ),
            body: const Row(
              children: [
                Expanded(child: Right()),
              ],
            ),
          );
        }

        // }
      },
    );
  }
}

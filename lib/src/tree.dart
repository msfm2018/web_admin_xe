import 'package:flutter/material.dart';
import 'left.dart';
import 'right.dart';
import 'tree_base.dart';

class TreeWidget extends StatelessWidget {
  final List<TreeBase> data;
  const TreeWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // 平板屏幕，显示两个页面
          return Row(children: <Widget>[Left(data: data), VerticalDivider(width: 2, color: Colors.black12, thickness: 2), Right()]);
        } else {
          // 手机屏幕，只显示一个页面
          // return const Row(children: [Right()]);

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
              child: Left(data: data), // 将左侧菜单放入 Drawer
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

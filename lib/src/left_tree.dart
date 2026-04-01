import 'package:flutter/material.dart';
import 'left_tree_item_widget.dart';
import 'left_tree_node.dart'; // 确认文件已更名

/// 树形列表视图：负责循环渲染多个 TreeBase 根节点
class LeftTreeListView extends StatefulWidget {
  final List<TreeBase>? data;
  const LeftTreeListView({super.key, this.data});

  @override
  LeftTreeListViewState createState() => LeftTreeListViewState();
}

class LeftTreeListViewState extends State<LeftTreeListView> {
  @override
  Widget build(BuildContext context) {
    final List<TreeBase> displayData = widget.data ?? [];

    return ListView.builder(
      // 增加物理滚动效果，提升桌面端体验
      physics: const BouncingScrollPhysics(),
    
      itemCount: displayData.length,
      itemBuilder: (BuildContext context, int index) {
        return TreeItemWidget(displayData[index]);
      },
    );
  }
}

/// 侧边栏主组件：负责处理响应式宽度和整体布局约束
class TreeSidebar extends StatefulWidget {
  final List<TreeBase>? data;
  const TreeSidebar({super.key, this.data});

  @override
  State<TreeSidebar> createState() => TreeSidebarState();
}

class TreeSidebarState extends State<TreeSidebar> {
  @override
  Widget build(BuildContext context) {
    // 优化响应式宽度逻辑：使用 clamp 限制最小和最大宽度
    double screenWidth = MediaQuery.of(context).size.width;
    // double sidebarWidth = (screenWidth * 1 / 7).clamp(266.0, 350.0);
    double sidebarWidth = (screenWidth * 1 / 7).clamp(180.0, 240.0);
const Color sidebarBgColor = Color(0xFF1E293B);
    return Container(
      width: sidebarWidth,
      // 建议增加一些视觉分割，比如背景色或右边框
      decoration: BoxDecoration(
        color:sidebarBgColor,// Theme.of(context).cardColor,
        border: Border(
          right: BorderSide(color: Colors.grey.withAlpha(40), width: 1),
        ),
      ),
      child: LeftTreeListView(data: widget.data),
    );
  }
}

import 'package:flutter/material.dart';
import 'left_tree_item_widget.dart';
import 'left_tree_node.dart';

/// 树形列表视图组件。
/// 
/// 该组件负责接收一个 [TreeBase] 列表，并使用 [ListView.builder] 进行高效的循环渲染。
/// 它通常作为 [TreeSidebar] 的内部实现，负责展示具体的节点内容。
class LeftTreeListView extends StatefulWidget {
  
  /// 树形结构的数据源。如果为 null，则渲染空列表。
  final List<TreeBase>? data;

  /// 创建一个 [LeftTreeListView]。
  const LeftTreeListView({super.key, this.data});

  @override
  LeftTreeListViewState createState() => LeftTreeListViewState();
}

/// [LeftTreeListView] 的状态类，处理滚动物理效果及列表构建。
class LeftTreeListViewState extends State<LeftTreeListView> {
  @override
  Widget build(BuildContext context) {
    final List<TreeBase> displayData = widget.data ?? [];

    return ListView.builder(
      /// 使用 [BouncingScrollPhysics] 提供更流畅的滚动反馈（特别是 macOS 和 iOS 端）。
      physics: const BouncingScrollPhysics(),
      itemCount: displayData.length,
      itemBuilder: (BuildContext context, int index) {
        // 渲染单个树节点项
        return TreeItemWidget(displayData[index]);
      },
    );
  }
}

/// 侧边栏主组件，负责处理响应式宽度和整体视觉容器。
/// 
/// [TreeSidebar] 会根据屏幕宽度动态计算自身的宽度，并提供深色的背景装饰
/// 以及右侧的分隔边框。
class TreeSidebar extends StatefulWidget {
  
  /// 侧边栏展示所需的树形数据。
  final List<TreeBase>? data;

  /// 创建一个 [TreeSidebar]。
  const TreeSidebar({super.key, this.data});

  @override
  State<TreeSidebar> createState() => TreeSidebarState();
}

/// [TreeSidebar] 的状态类，负责计算布局约束和样式。
class TreeSidebarState extends State<TreeSidebar> {
  @override
  Widget build(BuildContext context) {
    // 响应式宽度逻辑：
    // 根据屏幕宽度的 1/7 进行计算，并限制在 180px 到 240px 之间。
    final double screenWidth = MediaQuery.of(context).size.width;
    final double sidebarWidth = (screenWidth * 1 / 7).clamp(180.0, 240.0);
    
    /// 定义侧边栏背景颜色（深色调 0xFF1E293B）。
    const Color sidebarBgColor = Color(0xFF1E293B);

    return Container(
      width: sidebarWidth,
      decoration: BoxDecoration(
        color: sidebarBgColor,
        border: Border(
          // 增加微弱的右边框作为视觉分割
          right: BorderSide(color: Colors.grey.withAlpha(40), width: 1),
        ),
      ),
      // 内部嵌入列表视图
      child: LeftTreeListView(data: widget.data),
    );
  }
}
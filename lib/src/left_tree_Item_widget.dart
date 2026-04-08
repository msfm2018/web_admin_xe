import 'package:flutter/material.dart';
import 'package:rxflare/rxflare.dart';
import 'core.dart';
import 'left_tree_node.dart';

/// 树形结构中的单个节点组件。
///
/// 根据 [bean] 的类型（是否有子节点），自动渲染为：
/// * **叶子节点**: 一个可点击的列表项，通常关联一个页面跳转。
/// * **父节点**: 一个可展开/折叠的 [ExpansionTile]，包含子节点列表。
class TreeItemWidget extends StatefulWidget {
  /// 当前节点的数据模型。
  final TreeBase bean;

  /// 创建一个 [TreeItemWidget]。
  ///
  /// 接收 [bean] 作为渲染数据源。
  const TreeItemWidget(this.bean, {super.key});

  @override
  TreeItemWidgetState createState() => TreeItemWidgetState();
}

/// [TreeItemWidget] 的状态类，负责处理节点的交互逻辑与样式切换。
class TreeItemWidgetState extends State<TreeItemWidget> {
  @override
  Widget build(BuildContext context) {
    // 使用 Rx.custom 监听全局选中索引，实现选中态的局部刷新
    return Rx.custom(
      deps: [Core.instance.selectedNodeIndex],
      builder: () => _buildItem(widget.bean),
    );
  }

  /// 处理节点点击事件。
  ///
  /// 1. 更新 [Core.pageMap] 中对应页面的激活状态。
  /// 2. 调用 [Core.switchPage] 切换全局视图。
  void _handlePressed(TreeBase bean) {
    final core = Core.instance;
    final entry = core.pageMap.value.entries.where((e) => e.value.index == bean.index).firstOrNull;

    if (entry != null) {
      core.updatePageInfo(entry.key, entry.value.copyWith(isActive: true));
    }
    core.switchPage(bean.index);
  }

  /// 构建节点项。
  ///
  /// [depth] 表示当前嵌套深度，用于计算缩进 [indent]。
  Widget _buildItem(TreeBase bean, {int depth = 0}) {
    final isSelected = Core.instance.selectedNodeIndex.value == bean.index;
    final indent = depth * 20.0;

    return Padding(
      padding: EdgeInsets.only(left: indent, right: 12, top: 3, bottom: 3),
      child: bean.children.isEmpty ? _buildLeafNode(bean, isSelected) : _buildParentNode(bean, isSelected),
    );
  }

  /// 构建叶子节点（终端节点）。
  ///
  /// 包含图标显示、文字展示以及选中时的侧边高亮条。
  Widget _buildLeafNode(TreeBase bean, bool isSelected) {
    //  强制转换为 TreeNode 以获取图标属性
    final node = bean as TreeNode;

    return Material(
      color: isSelected ? Colors.blue.shade50 : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => _handlePressed(bean),
        hoverColor: Colors.grey.shade100,
        child: Container(
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: isSelected ? Border(left: BorderSide(color: Colors.blue.shade600, width: 4)) : null,
          ),
          child: Row(
            children: [
              // 渲染节点图标
              if (node.icon != null)
                Icon(
                  node.icon,
                  size: 18,
                  color: isSelected ? Colors.blue.shade700 : Colors.grey.shade600,
                ),
              if (node.icon != null) const SizedBox(width: 10),

              //  节点名称
              Expanded(
                child: Text(
                  bean.name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.blue.shade700 : const Color.fromARGB(255, 156, 152, 152),

                    // color: isSelected ? Colors.blue.shade700 : Colors.grey.shade800,
                  ),
                ),
              ),

              // 选中标记图标
              if (isSelected) Icon(Icons.check_rounded, size: 18, color: Colors.blue.shade600),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建父节点（容器节点）。
  ///
  /// 使用 [ExpansionTile] 提供折叠和展开子节点 [bean.children] 的能力。
  Widget _buildParentNode(TreeBase bean, bool isSelected) {
    return Theme(
      data: Theme.of(context).copyWith(
        expansionTileTheme: ExpansionTileThemeData(
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          iconColor: Colors.grey.shade600,
          textColor: Colors.grey.shade800,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          tilePadding: const EdgeInsets.symmetric(horizontal: 12),
          childrenPadding: EdgeInsets.zero,
        ),
      ),
      child: ExpansionTile(
        key: PageStorageKey<TreeBase>(bean),
        initiallyExpanded: false,
        trailing: Icon(
          Icons.expand_more,
          size: 20,
          color: Colors.grey.shade500,
        ),
        title: Text(
          bean.name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            // color: isSelected ? Colors.blue.shade700 : Colors.grey.shade800,
            color: isSelected ? Colors.white : Colors.white70, // 白色文字
          ),
        ),
        leading: Icon(
          Icons.folder_outlined,
          size: 20,
          color: isSelected ? Colors.blue.shade600 : Colors.grey.shade600,
        ),
        // 递归构建子节点
        children: bean.children.map((child) => _buildItem(child, depth: 1)).toList(),
      ),
    );
  }
}

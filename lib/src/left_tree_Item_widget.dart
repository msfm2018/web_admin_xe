import 'package:flutter/material.dart';
import 'package:rxflare/rxflare.dart';
import 'core.dart';
import 'left_tree_node.dart';

class TreeItemWidget extends StatefulWidget {
  final TreeBase bean;
  const TreeItemWidget(this.bean, {super.key});

  @override
  TreeItemWidgetState createState() => TreeItemWidgetState();
}

class TreeItemWidgetState extends State<TreeItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Rx.custom(
      deps: [Core.instance.selectedNodeIndex],
      builder: () => _buildItem(widget.bean),
    );
  }

  void _handlePressed(TreeBase bean) {
    final core = Core.instance;
    final entry = core.pageMap.value.entries.where((e) => e.value.index == bean.index).firstOrNull;

    if (entry != null) {
      core.updatePageInfo(entry.key, entry.value.copyWith(isActive: true));
    }
    core.switchPage(bean.index);
  }

  Widget _buildItem(TreeBase bean, {int depth = 0}) {
    final isSelected = Core.instance.selectedNodeIndex.value == bean.index;
    final indent = depth * 20.0;

    return Padding(
      padding: EdgeInsets.only(left: indent, right: 12, top: 3, bottom: 3),
      
      child: bean.children.isEmpty ? _buildLeafNode(bean, isSelected) : _buildParentNode(bean, isSelected),
    );
  }

  // ==================== 叶子节点（已加图标显示） ====================
  Widget _buildLeafNode(TreeBase bean, bool isSelected) {
    // 转成 TreeNode 拿 icon
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
              // ✅ 这里显示图标！
              if (node.icon != null)
                Icon(
                  node.icon,
                  size: 18,
                  color: isSelected ? Colors.blue.shade700 : Colors.grey.shade600,
                ),
              if (node.icon != null) const SizedBox(width: 10),

              // 文字
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

              // 选中标记
              if (isSelected) Icon(Icons.check_rounded, size: 18, color: Colors.blue.shade600),
            ],
          ),
        ),
      ),
    );
  }

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
        children: bean.children.map((child) => _buildItem(child, depth: 1)).toList(),
      ),
    );
  }
}

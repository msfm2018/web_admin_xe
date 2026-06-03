import 'package:flutter/material.dart';
import 'package:rxflare/rxflare.dart';
import 'core.dart';
import 'left_tree_node.dart';

/// A single node widget in the tree structure.
///
/// Depending on the type of [bean] (whether it has children),
/// this widget renders as:
/// 
/// * **Leaf node**: A clickable list item, typically used for page navigation.
/// * **Parent node**: An expandable [ExpansionTile] containing child nodes.
class TreeItemWidget extends StatefulWidget {
  /// The data model for the current node.
  final TreeBase bean;

  /// Creates a [TreeItemWidget].
  ///
  /// The [bean] is used as the data source for rendering.
  const TreeItemWidget(this.bean, {super.key});

  @override
  TreeItemWidgetState createState() => TreeItemWidgetState();
}

/// State class for [TreeItemWidget],
/// responsible for handling interaction logic and UI updates.
class TreeItemWidgetState extends State<TreeItemWidget> {
  @override
  Widget build(BuildContext context) {
    // Listen to global selected index for partial UI updates
    return Rx.custom(
      deps: [Core.instance.selectedNodeIndex],
      builder: () => _buildItem(widget.bean),
    );
  }

  /// Handles node click events.
  ///
  /// 1. Updates the corresponding page's active state in [Core.pageMap].
  /// 2. Calls [Core.switchPage] to update the global view.
  void _handlePressed(TreeBase bean) {
    final core = Core.instance;
    final entry = core.pageMap.value.entries
        .where((e) => e.value.index == bean.index)
        .firstOrNull;

    if (entry != null) {
      core.updatePageInfo(
        entry.key,
        entry.value.copyWith(isActive: true),
      );
    }
    core.switchPage(bean.index);
  }

  /// Builds a tree node item.
  ///
  /// [depth] indicates the nesting level and is used for indentation.
  Widget _buildItem(TreeBase bean, {int depth = 0}) {
    final isSelected =
        Core.instance.selectedNodeIndex.value == bean.index;
    final indent = depth * 20.0;

    return Padding(
      padding:
          EdgeInsets.only(left: indent, right: 12, top: 3, bottom: 3),
      child: bean.children.isEmpty
          ? _buildLeafNode(bean, isSelected)
          : _buildParentNode(bean, isSelected),
    );
  }

  /// Builds a leaf node (terminal node).
  ///
  /// Includes icon, text, and a highlight indicator when selected.
  Widget _buildLeafNode(TreeBase bean, bool isSelected) {
    final node = bean as TreeNode;

    return Material(
      color:
          isSelected ? Colors.blue.shade50 : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => _handlePressed(bean),
        hoverColor: Colors.grey.shade100,
        child: Container(
          height: 46,
          padding:
              const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: isSelected
                ? Border(
                    left: BorderSide(
                      color: Colors.blue.shade600,
                      width: 4,
                    ),
                  )
                : null,
          ),
          child: Row(
            children: [
              // Node icon
              if (node.icon != null)
                Icon(
                  node.icon,
                  size: 18,
                  color: isSelected
                      ? Colors.blue.shade700
                      : Colors.grey.shade600,
                ),
              if (node.icon != null)
                const SizedBox(width: 10),

              // Node title
              Expanded(
                child: Text(
                  bean.name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.w500,
                    color: isSelected
                        ? Colors.blue.shade700
                        : const Color.fromARGB(
                            255, 156, 152, 152),
                  ),
                ),
              ),

              // Selected indicator
              if (isSelected)
                Icon(
                  Icons.check_rounded,
                  size: 18,
                  color: Colors.blue.shade600,
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a parent node (container node).
  ///
  /// Uses [ExpansionTile] to support expand/collapse behavior
  /// for child nodes.
  Widget _buildParentNode(TreeBase bean, bool isSelected) {
    return Theme(
      data: Theme.of(context).copyWith(
        expansionTileTheme: ExpansionTileThemeData(
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          iconColor: Colors.grey.shade600,
          textColor: Colors.grey.shade800,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          tilePadding:
              const EdgeInsets.symmetric(horizontal: 12),
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
            color:
                isSelected ? Colors.white : Colors.white70,
          ),
        ),
        leading: Icon(
          Icons.folder_outlined,
          size: 20,
          color: isSelected
              ? Colors.blue.shade600
              : Colors.grey.shade600,
        ),

        // Recursively build child nodes
        children: bean.children
            .map((child) => _buildItem(child, depth: 1))
            .toList(),
      ),
    );
  }
}
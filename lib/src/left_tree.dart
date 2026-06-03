import 'package:flutter/material.dart';
import 'left_tree_item_widget.dart';
import 'left_tree_node.dart';

/// A tree list view widget.
///
/// This widget takes a list of [TreeBase] and renders it efficiently
/// using [ListView.builder].
///
/// It is typically used internally by [TreeSidebar] to display
/// the actual tree node items.
class LeftTreeListView extends StatefulWidget {
  /// The data source of the tree structure.
  ///
  /// If null, an empty list will be rendered.
  final List<TreeBase>? data;

  /// Creates a [LeftTreeListView].
  const LeftTreeListView({super.key, this.data});

  @override
  LeftTreeListViewState createState() => LeftTreeListViewState();
}

/// State class for [LeftTreeListView],
/// responsible for scroll behavior and list building.
class LeftTreeListViewState extends State<LeftTreeListView> {
  @override
  Widget build(BuildContext context) {
    final List<TreeBase> displayData = widget.data ?? [];

    return ListView.builder(
      /// Uses [BouncingScrollPhysics] for smoother scrolling,
      /// especially on macOS and iOS.
      physics: const BouncingScrollPhysics(),
      itemCount: displayData.length,
      itemBuilder: (BuildContext context, int index) {
        // Render a single tree node item
        return TreeItemWidget(displayData[index]);
      },
    );
  }
}

/// Sidebar container widget for the tree structure.
///
/// [TreeSidebar] dynamically adjusts its width based on screen size,
/// and provides a dark-themed background with a subtle right border.
class TreeSidebar extends StatefulWidget {
  /// The tree data to be displayed in the sidebar.
  final List<TreeBase>? data;

  /// Creates a [TreeSidebar].
  const TreeSidebar({super.key, this.data});

  @override
  State<TreeSidebar> createState() => TreeSidebarState();
}

/// State class for [TreeSidebar],
/// responsible for layout calculation and styling.
class TreeSidebarState extends State<TreeSidebar> {
  @override
  Widget build(BuildContext context) {
    // Responsive width calculation:
    // Uses 1/7 of the screen width, clamped between 180px and 240px.
    final double screenWidth = MediaQuery.of(context).size.width;
    final double sidebarWidth =
        (screenWidth * 1 / 7).clamp(180.0, 240.0);

    /// Sidebar background color (dark tone: 0xFF1E293B).
    const Color sidebarBgColor = Color(0xFF1E293B);

    return Container(
      width: sidebarWidth,
      decoration: BoxDecoration(
        color: sidebarBgColor,
        border: Border(
          // Subtle right border for visual separation
          right: BorderSide(
            color: Colors.grey.withAlpha(40),
            width: 1,
          ),
        ),
      ),
      // Embedded list view
      child: LeftTreeListView(data: widget.data),
    );
  }
}
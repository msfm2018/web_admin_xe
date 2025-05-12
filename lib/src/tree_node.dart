import 'package:flutter/material.dart';
import 'package:simple_tree/simple_tree.dart';

class TreeNode implements TreeBase {
  @override
  final String name;
  @override
  final int index;
  @override
  final List<TreeNode> children;
  @override
  final TextStyle? style;

  TreeNode({required this.index, required this.name, this.children = const <TreeNode>[], this.style});

  @override
  String toString() {
    return 'TreeNode{name: $name, children: $children, style: $style}';
  }
}

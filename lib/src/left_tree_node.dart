import 'package:flutter/material.dart';

/// Base abstract class for tree node data.
///
/// This class defines the core properties required for a tree structure.
/// All node models (such as [TreeNode]) must extend this class to ensure
/// compatibility with components like TreeWidget.
abstract class TreeBase {
  /// The display name of the node.
  String get name;

  /// The unique index identifier of the node.
  int get index;

  /// Custom text style for the node.
  /// If null, a global default style will be used.
  TextStyle? get style;

  /// List of child nodes.
  /// This should be empty for leaf nodes.
  List<TreeBase> get children;

  /// Icon associated with the node.
  IconData? get icon;

  /// Whether this node is a leaf node (i.e., has no children).
  bool get isLeaf => children.isEmpty;

  /// Recursively checks whether this node or its children
  /// contain the given keyword.
  ///
  /// [keyword] is case-insensitive.
  /// Returns true if the keyword matches this node's [name]
  /// or any descendant node.
  bool containsKeyword(String keyword) {
    if (keyword.isEmpty) return true;
    final cleanKey = keyword.toLowerCase();

    if (name.toLowerCase().contains(cleanKey)) return true;

    return children.any((child) => child.containsKeyword(keyword));
  }
}

/// Concrete implementation of [TreeBase].
///
/// Supports JSON deserialization and provides a [copyWith]
/// method for immutable updates.
class TreeNode extends TreeBase {
  /// Route name associated with this node.
  final String? page;

  @override
  final String name;

  @override
  final int index;

  @override
  final List<TreeNode> children;

  @override
  final TextStyle? style;

  @override
  final IconData? icon;

  /// Creates a [TreeNode].
  ///
  /// Both [index] and [name] are required.
  TreeNode({
    required this.index,
    required this.name,
    this.page,
    this.style,
    this.children = const <TreeNode>[],
    this.icon,
  });

  /// Returns a new [TreeNode] with updated fields.
  ///
  /// Commonly used for immutable state updates.
  TreeNode copyWith({
    String? name,
    List<TreeNode>? children,
    TextStyle? style,
    IconData? icon,
  }) {
    return TreeNode(
      index: index,
      name: name ?? this.name,
      children: children ?? this.children,
      style: style ?? this.style,
      page: page,
      icon: icon ?? this.icon,
    );
  }

  /// Creates a [TreeNode] from a JSON map.
  ///
  /// Supports recursive parsing of [children] and
  /// string-to-[IconData] mapping for [icon].
  factory TreeNode.fromJson(Map<String, dynamic> json) {
    return TreeNode(
      name: json['name'] ?? '',
      index: json['index'] ?? 0,
      page: json['page'],
      style: json['style'] != null
          ? TextStyle(color: Color(json['style'] as int))
          : null,
      icon: _getIconData(json['icon']),
      children: json['children'] != null
          ? (json['children'] as List)
              .map((e) => TreeNode.fromJson(e))
              .toList()
          : [],
    );
  }

  /// Internal helper: converts a string into [IconData].
  ///
  /// Supported values:
  /// 'home', 'settings', 'user', 'people', 'menu', 'dashboard'.
  ///
  /// Returns [Icons.circle] if no match is found.
  static IconData? _getIconData(dynamic iconStr) {
    if (iconStr == null) return null;
    if (iconStr is! String) return null;

    switch (iconStr.toLowerCase()) {
      case 'home':
        return Icons.home;
      case 'settings':
        return Icons.settings;
      case 'user':
        return Icons.person;
      case 'people':
        return Icons.people;
      case 'menu':
        return Icons.menu;
      case 'dashboard':
        return Icons.dashboard;
      default:
        return Icons.circle;
    }
  }
}
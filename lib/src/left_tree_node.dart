import 'package:flutter/material.dart';

/// 树节点抽象基类
abstract class TreeBase {
  String get name;
  int get index;
  TextStyle? get style;
  List<TreeBase> get children;
  IconData? get icon;

  bool get isLeaf => children.isEmpty;

  bool containsKeyword(String keyword) {
    if (keyword.isEmpty) return true;
    final cleanKey = keyword.toLowerCase();
    if (name.toLowerCase().contains(cleanKey)) return true;
    return children.any((child) => child.containsKeyword(keyword));
  }
}

/// 具体实现类
class TreeNode extends TreeBase {
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

  TreeNode({
    required this.index,
    required this.name,
    this.page,
    this.style,
    this.children = const <TreeNode>[],
    this.icon,
  });

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

  factory TreeNode.fromJson(Map<String, dynamic> json) {
    return TreeNode(
      name: json['name'] ?? '',
      index: json['index'] ?? 0,
      page: json['page'],
      style: json['style'] != null
          ? TextStyle(color: Color(json['style'] as int))
          : null,
      // ======================================
      // 👇 👇 👇 这里修复！！！支持字符串 icon 名称
      // ======================================
      icon: _getIconData(json['icon']),
      children: json['children'] != null
          ? (json['children'] as List)
              .map((e) => TreeNode.fromJson(e))
              .toList()
          : [],
    );
  }

  // ======================================
  // 新增：字符串转 IconData 工具方法（关键修复）
  // ======================================
  static IconData? _getIconData(dynamic iconStr) {
    if (iconStr == null) return null;
    if (iconStr is! String) return null;

    switch (iconStr.toLowerCase()) {
      case 'home': return Icons.home;
      case 'settings': return Icons.settings;
      case 'user': return Icons.person;
      case 'people': return Icons.people;
      case 'menu': return Icons.menu;
      case 'dashboard': return Icons.dashboard;
      default: return Icons.circle;
    }
  }
}
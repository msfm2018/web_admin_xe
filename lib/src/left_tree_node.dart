import 'package:flutter/material.dart';

/// 树节点的数据基础抽象类。
///
/// 该类定义了树形结构中节点所需的核心属性。所有的节点模型（如 [TreeNode]）
/// 都必须继承自此类，以确保与 [TreeWidget] 的兼容性。
abstract class TreeBase {
  /// 节点的显示名称。
  String get name;

  /// 节点的唯一标识索引。
  int get index;

  /// 节点的自定义文本样式。如果为 null，将使用全局默认样式。
  TextStyle? get style;

  /// 子节点列表。如果是叶子节点，该列表应为空。
  List<TreeBase> get children;

  /// 节点关联的图标数据。
  IconData? get icon;

  /// 判断当前节点是否为叶子节点（即没有子节点）。
  bool get isLeaf => children.isEmpty;

  /// 递归搜索：判断当前节点或其子节点是否包含指定的关键字。
  ///
  /// [keyword] 搜索关键字，不区分大小写。
  /// 如果匹配到当前节点的 [name] 或任意子节点的名称，则返回 true。
  bool containsKeyword(String keyword) {
    if (keyword.isEmpty) return true;
    final cleanKey = keyword.toLowerCase();
    if (name.toLowerCase().contains(cleanKey)) return true;
    return children.any((child) => child.containsKeyword(keyword));
  }
}

/// [TreeBase] 的具体实现类。
///
/// 支持通过 JSON 数据实例化，并提供了 [copyWith] 方法用于不可变状态的更新。
class TreeNode extends TreeBase {
  /// 节点关联的路由页面路径名称。
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

  /// 创建一个 [TreeNode] 实例。
  ///
  /// [index] 和 [name] 是必须填写的。
  TreeNode({
    required this.index,
    required this.name,
    this.page,
    this.style,
    this.children = const <TreeNode>[],
    this.icon,
  });

  /// 复制并创建一个新的 [TreeNode] 实例，同时替换部分属性。
  ///
  /// 常用于响应式状态管理中的不可变对象更新。
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

  /// 从 JSON 映射表中解析并创建 [TreeNode] 实例。
  ///
  /// 支持嵌套解析 [children] 字段，并能通过字符串名称映射 [icon]。
  factory TreeNode.fromJson(Map<String, dynamic> json) {
    return TreeNode(
      name: json['name'] ?? '',
      index: json['index'] ?? 0,
      page: json['page'],
      style: json['style'] != null ? TextStyle(color: Color(json['style'] as int)) : null,
      icon: _getIconData(json['icon']),
      children: json['children'] != null ? (json['children'] as List).map((e) => TreeNode.fromJson(e)).toList() : [],
    );
  }

  /// 内部辅助方法：将字符串类型的图标名称转换为 Flutter 的 [IconData]。
  ///
  /// 目前支持: 'home', 'settings', 'user', 'people', 'menu', 'dashboard'。
  /// 匹配失败时默认返回 [Icons.circle]。
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

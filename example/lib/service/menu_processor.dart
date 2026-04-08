import 'package:simple_tree/simple_tree.dart';

import '../route_mapper.dart';

class MenuProcessor {
  // 把入参改成 List<TreeBase> 更通用（兼容你现在的架构）
  static List<PageInfo> convertToPages(List<TreeBase> nodes) {
    List<PageInfo> pages = [];

    // 递归遍历（支持 TreeBase + 可选 icon）
    void walk(TreeBase node) {
      // 安全转换为 TreeNode 才能拿到 page / icon
      if (node is TreeNode) {
        final widget = RouteMapper.getPage(node.page);
        if (widget != null) {
          final builder = RouteMapper.routes[node.page];
          if (builder != null) {
            pages.add(PageInfo(
              index: node.index,
              title: node.name,
              builder: builder,
              // 👇 自动把菜单 icon 带给页面（可选，不传递也不报错）
              icon: node.icon ,
            ));
          }
        }
      }

      // 遍历子节点
      for (var child in node.children) {
        walk(child);
      }
    }

    for (var node in nodes) {
      walk(node);
    }
    return pages;
  }
}
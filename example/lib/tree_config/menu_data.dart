import 'package:flutter/material.dart';
import 'package:simple_tree/simple_tree.dart';
import '../view/p_1.dart';
import '../view/p_2.dart';
import '../view/p_indexstack.dart';
import '../view/page3.dart';

final List<TreeNode> data = <TreeNode>[
  TreeNode(
    1,
    '餐饮',
    style: const TextStyle(
      fontSize: 34.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  TreeNode(2, '西餐', children: [...westernCuisine]),
  TreeNode(3, '甜点', children: [
    TreeNode(4, '蛋糕', children: [...cakes]),
    ...otherDesserts,
  ]),
  TreeNode(5, '饮品', children: <TreeNode>[
    TreeNode(6, '茶饮'),
    TreeNode(7, '果汁'),
  ]),
];

final List<TreeNode> westernCuisine = [
  TreeNode(8, '意大利菜', style: const TextStyle(fontFamily: 'NotoSansSC', fontSize: 20.0, color: Colors.blue)),
  TreeNode(9, '法式料理'),
  TreeNode(10, '美式快餐'),
  TreeNode(11, '西班牙菜'),
];

final List<TreeNode> cakes = [
  TreeNode(12, '巧克力蛋糕'),
  TreeNode(13, '芝士蛋糕'),
  TreeNode(14, '草莓蛋糕'),
  TreeNode(15, '抹茶蛋糕'),
];

final List<TreeNode> otherDesserts = [
  TreeNode(16, '冰淇淋'),
  TreeNode(17, '布丁'),
  TreeNode(18, '马卡龙'),
  TreeNode(19, '泡芙'),
  TreeNode(20, '提拉米苏'),
  TreeNode(21, '果冻'),
];

//定义 一对一关系
List<PageInfo> myAppPages = [
  PageInfo(index: 1, title: '餐饮', widget: const P1()),
  PageInfo(index: 8, title: '意大利菜', widget: const P2()),
  PageInfo(index: 9, title: '法式料理', widget: const Page3()),
  PageInfo(index: 10, title: '美式快餐', widget: const TestIndexStack()),
];

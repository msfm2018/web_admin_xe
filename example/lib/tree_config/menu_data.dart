import 'package:flutter/material.dart';
import 'package:simple_tree/simple_tree.dart';
import '../view/p_1.dart';
import '../view/p_2.dart';
import '../view/p_indexstack.dart';
import '../view/page3.dart';

final List<TreeNode> data = <TreeNode>[
  TreeNode(
    index: 1,
    name: '餐饮',
    style: const TextStyle(
      fontSize: 34.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  TreeNode(index: 2, name: '西餐', children: [...westernCuisine]),
  TreeNode(index: 3, name: '甜点', children: [
    TreeNode(index: 4, name: '蛋糕', children: [...cakes]),
    ...otherDesserts,
  ]),
  TreeNode(index: 5, name: '饮品', children: <TreeNode>[
    TreeNode(index: 6, name: '茶饮'),
    TreeNode(index: 7, name: '果汁'),
  ]),
];

final List<TreeNode> westernCuisine = [
  TreeNode(index: 8, name: '意大利菜', style: const TextStyle(fontFamily: 'NotoSansSC', fontSize: 20.0, color: Colors.blue)),
  TreeNode(index: 9, name: '法式料理'),
  TreeNode(index: 10, name: '美式快餐'),
  TreeNode(index: 11, name: '西班牙菜'),
];

final List<TreeNode> cakes = [
  TreeNode(index: 12, name: '巧克力蛋糕'),
  TreeNode(index: 13, name: '芝士蛋糕'),
  TreeNode(index: 14, name: '草莓蛋糕'),
  TreeNode(index: 15, name: '抹茶蛋糕'),
];

final List<TreeNode> otherDesserts = [
  TreeNode(index: 16, name: '冰淇淋'),
  TreeNode(index: 17, name: '布丁'),
  TreeNode(index: 18, name: '马卡龙'),
  TreeNode(index: 19, name: '泡芙'),
  TreeNode(index: 20, name: '提拉米苏'),
  TreeNode(index: 21, name: '果冻'),
];

//定义 一对一关系
List<PageInfo> myAppPages = [
  PageInfo(index: 1, title: '餐饮', widget: const P1()),
  PageInfo(index: 8, title: '意大利菜', widget: const P2()),
  PageInfo(index: 9, title: '法式料理', widget: const Page3()),
  PageInfo(index: 10, title: '美式快餐', widget: const TestIndexStack()),
];

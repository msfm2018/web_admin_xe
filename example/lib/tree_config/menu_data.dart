import 'package:flutter/material.dart';
import 'package:simple_tree/simple_tree.dart';
import '../view/p_1.dart';
import '../view/p_2.dart';
import '../view/p_indexstack.dart';
import '../view/page3.dart';

final List<DataBean> data = <DataBean>[
  DataBean(
    1,
    '餐饮',
    style: const TextStyle(
      fontSize: 34.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  DataBean(2, '西餐', children: [...westernCuisine]),
  DataBean(3, '甜点', children: [
    DataBean(4, '蛋糕', children: [...cakes]),
    ...otherDesserts,
  ]),
  DataBean(5, '饮品', children: <DataBean>[
    DataBean(6, '茶饮'),
    DataBean(7, '果汁'),
  ]),
];

final List<DataBean> westernCuisine = [
  DataBean(8, '意大利菜', style: const TextStyle(fontFamily: 'NotoSansSC', fontSize: 20.0, color: Colors.blue)),
  DataBean(9, '法式料理'),
  DataBean(10, '美式快餐'),
  DataBean(11, '西班牙菜'),
];

final List<DataBean> cakes = [
  DataBean(12, '巧克力蛋糕'),
  DataBean(13, '芝士蛋糕'),
  DataBean(14, '草莓蛋糕'),
  DataBean(15, '抹茶蛋糕'),
];

final List<DataBean> otherDesserts = [
  DataBean(16, '冰淇淋'),
  DataBean(17, '布丁'),
  DataBean(18, '马卡龙'),
  DataBean(19, '泡芙'),
  DataBean(20, '提拉米苏'),
  DataBean(21, '果冻'),
];

//定义 一对一关系
List<PageInfo> myAppPages = [
  PageInfo(index: 1, title: '餐饮', widget: const P1()),
  PageInfo(index: 8, title: '意大利菜', widget: const P2()),
  PageInfo(index: 9, title: '法式料理', widget: const Page3()),
  PageInfo(index: 10, title: '美式快餐', widget: const TestIndexStack()),
];

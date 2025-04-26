import 'package:flutter/material.dart';
import 'package:simple_tree/simple_tree.dart';
import '../view/p_1.dart';
import '../view/p_2.dart';
import '../view/p_indexstack.dart';
import '../view/page3.dart';
import 'menu_node.dart';

final List<DataBean> data = <DataBean>[
  DataBean(
    '餐饮',
    style: const TextStyle(
      fontSize: 34.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  DataBean('西餐', children: [...westernCuisine]),
  DataBean('甜点', children: [
    DataBean('蛋糕', children: [...cakes]),
    ...otherDesserts,
  ]),
  DataBean('饮品', children: <DataBean>[
    DataBean('茶饮'),
    DataBean('果汁'),
  ]),
];

final List<DataBean> westernCuisine = [
  DataBean('意大利菜', style: const TextStyle(fontFamily: 'NotoSansSC', fontSize: 20.0, color: Colors.blue)),
  DataBean('法式料理'),
  DataBean('美式快餐'),
  DataBean('西班牙菜'),
];

final List<DataBean> cakes = [
  DataBean('巧克力蛋糕'),
  DataBean('芝士蛋糕'),
  DataBean('草莓蛋糕'),
  DataBean('抹茶蛋糕'),
];

final List<DataBean> otherDesserts = [
  DataBean('冰淇淋'),
  DataBean('布丁'),
  DataBean('马卡龙'),
  DataBean('泡芙'),
  DataBean('提拉米苏'),
  DataBean('果冻'),
];

//定义 一对一关系
List<PageInfo> myAppPages = [
  PageInfo(name: '餐饮', widget: const P1()),
  PageInfo(name: '意大利菜', widget: const P2()),
  PageInfo(name: '法式料理', widget: Page3()),
  PageInfo(name: '美式快餐', widget: const TestIndexStack()),
];

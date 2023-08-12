import 'package:flutter/material.dart';
import '../view/p_1.dart';
import '../view/p_2.dart';
import '../view/p_3.dart';
import '../view/p_indexstack.dart';
import '../view/p_keep_live.dart';

List<MyData> lst = [
  MyData(title: '照片', obj: const P1()),
  MyData(title: '留言薄', obj: const P2()),
  MyData(title: '天津', obj:P3('鱼丸')),
  MyData(title: '重庆', obj:const SAreaAgeGenderMain()),
  MyData(title: '大西洋', obj:const TestIndexStack()),
];

class MyData {
  final String title;
  final Widget obj;

  MyData({required this.title, required this.obj});
}
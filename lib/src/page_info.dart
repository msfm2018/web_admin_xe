import 'package:flutter/cupertino.dart';

class PageInfo {
  final String title;
  final int index;
  final Widget widget;
  bool isActive;

  PageInfo({required this.index, required this.title, required this.widget, this.isActive = false});
}

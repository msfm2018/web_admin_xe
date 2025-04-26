
import 'package:flutter/cupertino.dart';

class PageInfo {
  final String name;
  final Widget widget;
  bool isActive;

  PageInfo({required this.name, required this.widget, this.isActive = false});
}



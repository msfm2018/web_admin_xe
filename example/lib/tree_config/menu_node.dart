import 'package:flutter/material.dart';
import 'package:simple_tree/simple_tree.dart';

class DataBean implements TreeData {
  @override
  final String name;
  @override
  final List<DataBean> children;
  @override
  final TextStyle? style; // 新增可选样式属性

  DataBean(this.name, {this.children = const <DataBean>[], this.style});

  @override
  String toString() {
    return 'DataBean{name: $name, children: $children, style: $style}';
  }
}

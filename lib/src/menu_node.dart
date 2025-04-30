import 'package:flutter/material.dart';
import 'package:simple_tree/simple_tree.dart';

class DataBean implements TreeData {
  @override
  final String name;
  @override
  final int index;
  @override
  final List<DataBean> children;
  @override
  final TextStyle? style;

  DataBean(this.index, this.name, {this.children = const <DataBean>[], this.style});

  @override
  String toString() {
    return 'DataBean{name: $name, children: $children, style: $style}';
  }
}

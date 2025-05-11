// lib/data.dart
import 'package:flutter/material.dart';

abstract class TreeBase {
  String get name;
  int get index;
  TextStyle? get style;
  List<TreeBase> get children;
}

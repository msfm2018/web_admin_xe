// lib/data.dart
import 'package:flutter/material.dart';

abstract class TreeData {
  String get name;
  TextStyle? get style;
  List<TreeData> get children;
}

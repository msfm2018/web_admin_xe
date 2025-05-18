import 'package:flutter/cupertino.dart';

class PageInfo {
  final String title;
  final int index;
  final Widget widget;
  bool isActive;

  PageInfo({required this.index, required this.title, required this.widget, this.isActive = false});

  PageInfo copyWith({
    String? title,
    int? index,
    Widget? widget,
    bool? isActive,
  }) {
    return PageInfo(
      title: title ?? this.title,
      index: index ?? this.index,
      widget: widget ?? this.widget,
      isActive: isActive ?? this.isActive,
    );
  }
}

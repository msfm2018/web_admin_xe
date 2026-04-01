import 'package:flutter/material.dart';

class PageInfo {
  final int index;
  final String title;
  final Widget Function() builder;
  final bool isActive;
  final IconData? icon; // 加这行
  PageInfo({
    required this.index,
    required this.title,
    required this.builder,
    this.isActive = false,
    this.icon,
  });

  PageInfo copyWith({
    int? index,
    String? title,
    Widget Function()? builder,
    bool? isActive,
      IconData? icon,
  }) {
    return PageInfo(
      index: index ?? this.index,
      title: title ?? this.title,
      builder: builder ?? this.builder,
      isActive: isActive ?? this.isActive,
       icon: icon ?? this.icon,
    );
  }
}

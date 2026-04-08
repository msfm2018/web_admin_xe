import 'package:flutter/material.dart';

/// 页面信息模型类。
/// 
/// 该类用于封装树节点所关联的页面属性，包括唯一索引、标题、构建方法及状态。
/// 它通常被 [Core.pageMap] 管理，用于在主内容区域渲染对应的视图。
class PageInfo {
  
  /// 页面的唯一标识索引。应与对应的 [TreeBase.index] 保持一致。
  final int index;
  
  /// 页面的标题，通常用于显示在标签页 (Tabs) 或面包屑导航中。
  final String title;
  
  /// 页面的构建工厂方法。
  /// 
  /// 使用函数签名 `Widget Function()` 以实现延迟加载，只有在页面被激活时才执行构建逻辑。
  final Widget Function() builder;
  
  /// 页面当前的激活状态。
  /// 
  /// 为 `true` 时表示该页面正在被用户查看或处于活动标签中。
  final bool isActive;
  
  /// 页面关联的图标。
  /// 
  /// 可选字段，用于在导航栏或标签页中增强视觉识别度。
  final IconData? icon;

  /// 创建一个 [PageInfo] 实例。
  /// 
  /// * [index], [title], [builder] 为必填参数。
  /// * [isActive] 默认为 `false`。
  PageInfo({
    required this.index,
    required this.title,
    required this.builder,
    this.isActive = false,
    this.icon,
  });

  /// 复制并创建一个新的 [PageInfo] 实例。
  /// 
  /// 该方法在状态管理中非常关键。由于 `rxflare` 依赖对象引用的改变来检测更新，
  /// 当你需要修改 [isActive] 等属性时，应调用此方法生成新对象。
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
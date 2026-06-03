import 'package:flutter/material.dart';

/// Model class representing page information.
///
/// This class encapsulates the properties associated with a page
/// linked to a tree node, including its unique index, title,
/// builder function, and state.
///
/// It is typically managed by `Core.pageMap` and used to render
/// the corresponding view in the main content area.
class PageInfo {
  /// Unique identifier of the page.
  ///
  /// Should match the corresponding `TreeBase.index`.
  final int index;

  /// Title of the page.
  ///
  /// Commonly used in tabs or breadcrumb navigation.
  final String title;

  /// Builder function for the page.
  ///
  /// Uses `Widget Function()` to support lazy loading,
  /// meaning the widget is only built when the page is activated.
  final Widget Function() builder;

  /// Whether the page is currently active.
  ///
  /// When `true`, the page is visible or selected by the user.
  final bool isActive;

  /// Icon associated with the page.
  ///
  /// Optional, used for better visual representation
  /// in navigation or tabs.
  final IconData? icon;

  /// Creates a [PageInfo] instance.
  ///
  /// [index], [title], and [builder] are required.
  /// [isActive] defaults to `false`.
  PageInfo({
    required this.index,
    required this.title,
    required this.builder,
    this.isActive = false,
    this.icon,
  });

  /// Returns a new [PageInfo] with updated fields.
  ///
  /// This method is essential for state management.
  /// Since `rxflare` relies on object reference changes to detect updates,
  /// you should use this method when modifying properties such as [isActive].
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
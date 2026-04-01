// 专门的路由映射表，与 UI 逻辑分离
import 'package:flutter/material.dart';

import 'view/AdminDashboardPage.dart';
import 'view/DashboardPage.dart';
import 'view/p_1.dart';
import 'view/p_2.dart';
import 'view/p_indexstack.dart';

class RouteMapper {
  static final Map<String, Widget Function()> routes = {
    "dashboard": () => const DashboardPage(),
    "user": () => const P1(),
    "role": () => const P2(),
    "test": () => const TestIndexStack(),
    "DashboardChart": () => const   DashboardChart(),
    "AdminDashboardPage": () =>  AdminDashboardPage(),
  };

  static Widget? getPage(String? key) {
    final builder = routes[key];
    return builder?.call(); // 用的时候才创建
  }
}
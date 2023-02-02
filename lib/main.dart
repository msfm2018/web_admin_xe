import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'constans/constans.dart';
import 'not_found.dart';
import 'login.dart';

Future<void> main() async {
  /// 确保初始化
  WidgetsFlutterBinding.ensureInitialized();

  /// 自定义报错提示
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    FlutterError.dumpErrorToConsole(flutterErrorDetails);
    if (kReleaseMode) {
      //上传错误
    }
    return const Material(
      child: Center(
        child: Text('出现错误'),
      ),
    );
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const title = 'flutter企业级UI管理框架';
  @override
  Widget build(BuildContext context) {
    ///树展开

    return MaterialApp(
        title: title,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          textTheme: AppTheme.textTheme,
          platform: TargetPlatform.windows,
          canvasColor: Colors.transparent,
          textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.green),
          scaffoldBackgroundColor: const Color.fromARGB(255, 221, 230, 236),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        onGenerateRoute: _routeGenerator);
  }

  /// 实现路由守卫
  Route _routeGenerator(RouteSettings settings) {
    if (kDebugMode) {
      print('on guard::::::::${settings.name}');
    }
    final name = settings.name;
    var builder = routeList[name];
    builder ??= (content) => const NotFound();
    // 用户权限认证的逻辑处理

    // 构建动态的route
    final route = MaterialPageRoute(
      builder: builder,
      settings: settings,
    );
    return route;
  }
}

Map<String, WidgetBuilder> routeList = {
  "notFound": (content) => const NotFound(),
  "login": (content) => const Login(),
  // "login": (content) => const Home(),
  // "main": (content) => const Home(),
};

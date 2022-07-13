import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'constans/constans.dart';
import 'home.dart';
import 'not_found.dart';
import 'view/base_view/login.dart';

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

  // await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ])
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
          primarySwatch: Colors.blue,
          textTheme: AppTheme.textTheme,
          platform: TargetPlatform.iOS,
          canvasColor: Colors.transparent,
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Colors.green),
          scaffoldBackgroundColor: AppTheme.notWhite,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        onGenerateRoute: _routeGenerator);
  }

  /// 实现路由守卫
  Route _routeGenerator(RouteSettings settings) {
    print('实现路由守卫::::::::' + settings.name.toString());
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
  // "main": (content) => const Home(),
};

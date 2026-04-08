import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxflare/rxflare.dart';

import 'login_page.dart';
import 'auth.dart';
import 'home.dart';
import 'not_found.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    logError(flutterErrorDetails);

    if (kReleaseMode) {
      // uploadError(flutterErrorDetails);
    }
    return Material(
      child: Center(
        child: Text(
          kDebugMode ? 'Error: ${flutterErrorDetails.exceptionAsString()}' : 'An error occurred. Please try again later.',
        ),
      ),
    );
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //       title: 'UI管理框架',
  //       theme: ThemeData(
  //         canvasColor: Colors.transparent,
  //       ),
  //       debugShowCheckedModeBanner: false,
  //       initialRoute: 'main',
  //       onGenerateRoute: _routeGenerator);
  // }
  @override
  Widget build(BuildContext context) {
    return Rx.custom(
      deps: [Auth.isLoggedIn],
      builder: () {
        final loggedIn = Auth.isLoggedIn.value;

        return MaterialApp(
          title: 'UI管理框架',
          theme: ThemeData(
            canvasColor: Colors.transparent,
          ),
          debugShowCheckedModeBanner: false,
          home: loggedIn ? const Home() :   LoginPage(), // 👈 推荐
          onGenerateRoute: _routeGenerator,
        );
      },
    );
  }

  Route _routeGenerator(RouteSettings settings) {
    var builder = routeList[settings.name];

    final route = MaterialPageRoute(
      builder: builder ??= (content) => const NotFound(),
      settings: settings,
    );
    return route;
  }
}

Map<String, WidgetBuilder> routeList = {
  "notFound": (content) => const NotFound(),
  "main": (content) => const Home(),
};

// 考虑使用集中日志记录功能以提高错误跟踪
void logError(FlutterErrorDetails details) {
  FlutterError.dumpErrorToConsole(details);
}

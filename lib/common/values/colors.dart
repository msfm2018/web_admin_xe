import 'dart:ui';

class AppColors extends Color {
  AppColors(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  /// 主文本
  static const Color primaryText = Color.fromARGB(255, 45, 45, 47);

  /// 主控件-背景
  static const Color primaryElement = Color.fromARGB(255, 41, 103, 255);

  /// 主控件-文本
  static const Color primaryElementText = Color.fromARGB(255, 255, 255, 255);
}

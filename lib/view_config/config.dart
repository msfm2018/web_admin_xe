import '../view/p_1.dart';
import '../view/p_keep_live.dart';

import '../tree_core/core.dart';
import '../view/p_2.dart';
import '../view/p_3.dart';
import '../view/p_indexstack.dart';

class Config {
  static init() {
    Core().pages.putIfAbsent('北京', () => const P1());
    Core().pages.putIfAbsent('上海', () => const P2());
    Core().pages.putIfAbsent('天津', () => P3('鱼丸'));

    Core().pages.putIfAbsent('重庆', () => const SAreaAgeGenderMain());
    Core().pages.putIfAbsent('越南', () => const TestIndexStack());
  }
}

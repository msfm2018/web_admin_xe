import '../view/p_1.dart';
import '../view/p_keep_live.dart';

import '../view/base_view/mgr.dart';
import '../view/p_2.dart';
import '../view/p_3.dart';
import '../view/p_indexstack.dart';

class Config {
  static init() {
    Mgr().vView.putIfAbsent('北京', () => const P1());
    Mgr().vView.putIfAbsent('上海', () => const P2());
    Mgr().vView.putIfAbsent('天津', () => P3('鱼丸'));

    Mgr().vView.putIfAbsent('重庆', () => const SAreaAgeGenderMain());
    Mgr().vView.putIfAbsent('越南', () => const TestIndexStack());
  }
}

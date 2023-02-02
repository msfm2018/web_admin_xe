import '../view/p_1.dart';
import '../view/p_keep_live.dart';

import '../tree_core/core.dart';
import '../view/p_2.dart';
import '../view/p_3.dart';
import '../view/p_indexstack.dart';

//树对应的 页面配置
class Config {
  static init() {
    Core.instance.pages.putIfAbsent('北京', () => const P1());
    Core.instance.pages.putIfAbsent('上海', () => const P2());
    Core.instance.pages.putIfAbsent('天津', () => P3('鱼丸'));

    Core.instance.pages.putIfAbsent('重庆', () => const SAreaAgeGenderMain());
    Core.instance.pages.putIfAbsent('大西洋', () => const TestIndexStack());
  }
}

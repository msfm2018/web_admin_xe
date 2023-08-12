
import '../tree_core/core.dart';
import 'data.dart';

//树对应的 页面配置
class Config {
  static init() {

    for (var element in lst) {
      //已有页面加载入内存中
      Core.instance.pages.putIfAbsent(element.title, () => element.obj);
    }

  }
}

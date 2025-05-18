import 'package:flutter/material.dart';
import 'package:rxflare/rxflare.dart';
import 'page_info.dart';
import 'core.dart';

class Right extends StatefulWidget {
  const Right({super.key});

  @override
  State<Right> createState() => RightState();
}

class RightState extends State<Right> with TickerProviderStateMixin {
  late ScrollController _scrollController2;

  @override
  void initState() {
    super.initState();
    _scrollController2 = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Column(children: [toolbar(), Expanded(child: _visiblePage())]));
  }

  Widget container(text) => Container(alignment: Alignment.center, child: Text(text, style: const TextStyle(fontSize: 18)));

  Widget _visiblePage() {
    return Rx.custom(
      deps: [Core.instance.pageAction],
      builder: () {
        final snapshotData = Core.instance.pageAction.value;
        try {
          final entry2 = Core.instance.pageMap.value.entries.firstWhere((entry) => entry.value.index == snapshotData);
          return entry2.value.widget;
        } catch (e) {
          return container("No page found");
        }
      },
    );
  }

  Color? foregroundColor(Set<WidgetState> states) {
    if (states.contains(WidgetState.focused) || states.contains(WidgetState.hovered)) {
      return Colors.white;
    }
    return null;
  }

  Widget text(text) => Text(text, style: const TextStyle(fontFamily: 'WorkSans', letterSpacing: 0.2, fontWeight: FontWeight.w400, color: Color(0xFF4A6572), fontSize: 14));

  Color? overlayColor(Set<WidgetState> states) {
    if (states.contains(WidgetState.focused)) {
      return Colors.grey.withAlpha(255);
    }
    if (states.contains(WidgetState.hovered)) {
      return Colors.blue[200];
    }
    return null;
  }

  @override
  void dispose() {
    _scrollController2.dispose();
    super.dispose();
  }

  Widget toolbar() {
    return Rx.custom(
      deps: [Core.instance.btnAction, Core.instance.pageMap, Core.instance.selectedNodeIndex],
      builder: () {
        print("toolbar builder 执行");
        final activePages = Core.instance.pageMap.value.entries.where((entry) => entry.value.isActive).toList();
        if (activePages.isEmpty) {
          return Container();
        }
        return Container(
          margin: const EdgeInsets.only(top: 6, bottom: 6),
          child: SingleChildScrollView(
            controller: _scrollController2,
            primary: false,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: activePages.map((entry) {
                return Container(
                  height: 24.0 * 1.0,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: entry.value.index == Core.instance.selectedNodeIndex.value ? Core.instance.selectedColor : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 24.0,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: entry.value.index == Core.instance.selectedNodeIndex.value ? Core.instance.selectedColor : Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              // 点击标题部分
                              InkWell(
                                borderRadius: BorderRadius.circular(4),
                                onTap: () => _handleSelection(entry),
                                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: text(entry.value.title)),
                              ),
                              // 分隔间距
                              const SizedBox(width: 4),
                              // 点击关闭图标
                              InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () => _handleIconButton(entry),
                                child: Padding(padding: const EdgeInsets.all(4.0), child: Icon(Icons.close_outlined, size: 12, color: Colors.grey[700])),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _handleSelection(MapEntry<int, PageInfo> entry) {
    int k = entry.value.index;
    Core.instance.selectedNodeIndex.value = k;
    Core.instance.notifyBtns(k);
    Core.instance.notifyPage(k);
    Core.instance.notifyItem(k);
  }

  void _handleIconButton(MapEntry<int, PageInfo> entry) {
    print("mygod.........+++.......");
    print(entry.value.isActive.toString());
    print(entry.value.toString());
    // entry.value.isActive = false; // 直接修改，应该通过 Core 更新
    try {
      // final activeEntry = Core.instance.pageMap.value.entries.firstWhere((entry) => entry.value.isActive);
      // int k = activeEntry.value.index;
      // print(k.toString());
      // Core.instance.selectedNodeIndex.value = k;
      // Core.instance.notifyItem(k);
      // Core.instance.notifyPage(k);
      // Core.instance.notifyBtns(k);

      //  使用 updatePageInfo 来更新 isActive
      final updatedEntry = entry.value.copyWith(isActive: false);
      Core.instance.updatePageInfo(entry.key, updatedEntry);

      //  如果关闭的是当前选中的，需要更新选中项
      if (entry.value.index == Core.instance.selectedNodeIndex.value) {
        //  找到第一个激活的页面并选中它
        final activeEntry = Core.instance.pageMap.value.entries.firstWhere(
          (entry) => entry.value.isActive,
          orElse: () => MapEntry(-1, PageInfo(index: -1, title: 'None', widget: Container())), // 默认值
        );
        Core.instance.selectedNodeIndex.value = activeEntry.value.index;
        Core.instance.notifyBtns(activeEntry.value.index);
        Core.instance.notifyPage(activeEntry.value.index);
        Core.instance.notifyItem(activeEntry.value.index);
      }
    } catch (e) {
      Core.instance.notifyPage(-1);
      Core.instance.notifyBtns(-1);
    }
  }
}

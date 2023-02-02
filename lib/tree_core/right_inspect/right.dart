// import 'dart:ffi';

import 'package:flutter/material.dart';

import '../core.dart';
import '../../common/utils/indexed_stack_wrapper.dart';

class Right extends StatefulWidget {
  const Right({Key? key}) : super(key: key);

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
    return Expanded(
        child: Column(
      children: [
        btnBuild(),
        Expanded(child: viewBuild()),
      ],
    ));
  }

  StreamBuilder<String> viewBuild() {
    return StreamBuilder(
        stream: Core.instance.pageControlerAction.stream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(); // const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              int currentIndex = Core.instance.openedPageList.indexOf(snapshot.data.toString());
              if (currentIndex == -1) {
                if (Core.instance.openedPageList.isNotEmpty) {
                  currentIndex = 0;
                }
              }

              return Core.instance.openedPageList.isEmpty
                  ? const Text('首页')
                  : Core.instance.pages[snapshot.data.toString()] == null
                      ? const Text('暂时没有页面对应')
                      : IndexedStackWrapper(
                          index: currentIndex,
                          children: Core.instance.openedPageList.map((e) {
                            return KeyedSubtree(key: Key(e), child: Core.instance.pages[e] as Widget);
                          }).toList(),
                        );
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        });
  }

  StreamBuilder<String> btnBuild() {
    Color? overlayColor(Set<MaterialState> states) {
      if (states.contains(MaterialState.focused)) {
        return Colors.grey.withOpacity(0.8);
      }
      if (states.contains(MaterialState.hovered)) {
        return Colors.blue[200];
      }
      return null;
    }

    Color? foregroundColor(Set<MaterialState> states) {
      if (states.contains(MaterialState.focused) || states.contains(MaterialState.hovered)) {
        return Colors.white;
      }
      return null;
    }

    return StreamBuilder(
        stream: Core.instance.btnControlerAction.stream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              return Container(
                  margin: const EdgeInsets.only(top: 6, bottom: 6),

                  ///创建快捷button
                  child: SingleChildScrollView(
                    controller: _scrollController2,
                    primary: false,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        //标题栏快捷按钮
                        for (var i = 0; i < Core.instance.openedPageList.length; i++)
                          Container(

                              ///每个按钮限制的高度
                              height: 30.0 * 1.0,
                              margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                              decoration: BoxDecoration(
                                color: Core.instance.openedPageList[i] == Core.instance.selectedNodeName ? Core.instance.selectedColor : Colors.deepOrange[100],
                                borderRadius: const BorderRadius.all(Radius.circular(4)),
                              ),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                TextButton(
                                    style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.resolveWith<Color?>(overlayColor),
                                        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                                          foregroundColor,
                                        ),
                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                                        backgroundColor: MaterialStateProperty.all(Colors.transparent)),
                                    child: Text(
                                      Core.instance.openedPageList[i],
                                      style: const TextStyle(fontFamily: 'WorkSans', letterSpacing: 0.2, fontWeight: FontWeight.w400, color: Color(0xFF4A6572), fontSize: 12),
                                    ),
                                    onPressed: () {
                                      String k = Core.instance.openedPageList[i];

                                      Core.instance.selectedNodeName = k;

                                      Core.instance.notifyBtns(k);
                                      Core.instance.notifyPage(k);
                                      Core.instance.notifyItem(k);
                                    }),

                                ///关闭图标
                                Material(
                                    child: IconButton(
                                  style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.resolveWith<Color?>(overlayColor),
                                      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                                        foregroundColor,
                                      ),
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                                      backgroundColor: MaterialStateProperty.all(Colors.transparent)),
                                  iconSize: 18,
                                  color: Colors.white,
                                  onPressed: () {
                                    String k = Core.instance.openedPageList[i];
                                    Core().openedPageList.remove(k);

                                    if (Core().openedPageList.isNotEmpty) {
                                      k = Core.instance.openedPageList[Core().openedPageList.length - 1];
                                      Core.instance.selectedNodeName = k;
                                      // 通知tree发生变化
                                      Core.instance.notifyItem(k);
                                      // 通知页面发生变化
                                      Core.instance.notifyPage(k);
                                      //通知标题栏button
                                      Core.instance.notifyBtns(k);
                                    } else {
                                      Core.instance.notifyPage(k);
                                      Core.instance.notifyBtns(k);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                  ),
                                )

                                    ///
                                    )
                              ])),
                      ],
                    ),
                  )

                  ///
                  );
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        });
  }
}

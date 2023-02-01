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
        stream: Core().idControler.stream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(); // const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              int currentIndex =
                  Core().openedTabPageList.indexOf(snapshot.data.toString());
              if (currentIndex == -1) {
                if (Core().openedTabPageList.isNotEmpty) {
                  currentIndex = 0;
                }
              }

              return Core().openedTabPageList.isEmpty
                  ? const Text('首页')
                  : Core().pages[snapshot.data.toString()] == null
                      ? const Text('暂时没有页面对应')
                      : IndexedStackWrapper(
                          index: currentIndex,
                          children: Core().openedTabPageList.map((e) {
                            return KeyedSubtree(
                                key: Key(e), child: Core().pages[e] as Widget);
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
      if (states.contains(MaterialState.focused) ||
          states.contains(MaterialState.hovered)) {
        return Colors.white;
      }
      return null;
    }

    return StreamBuilder(
        stream: Core().idControlerAction.stream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              return Container(
                  margin: const EdgeInsets.only(top: 6),

                  ///创建快捷button
                  child: SingleChildScrollView(
                    controller: _scrollController2,
                    primary: false,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        //标题快捷按钮
                        for (var i = 0;
                            i < Core().openedTabPageList.length;
                            i++)
                          Container(

                              ///每个按钮限制的高度
                              height: 30.0 * 0.8,
                              margin:
                                  const EdgeInsets.only(left: 6.0, right: 6.0),
                              decoration: BoxDecoration(
                                color: Core().openedTabPageList[i] ==
                                        Core().selectedNodeName
                                    ? Core().selectedColor
                                    : Colors.deepOrange[100],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                              ),
                              child: Row(children: [
                                Stack(children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    child: TextButton(
                                        style: ButtonStyle(
                                            overlayColor: MaterialStateProperty
                                                .resolveWith<Color?>(
                                                    overlayColor),
                                            foregroundColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color?>(
                                              foregroundColor,
                                            ),
                                            //圆角
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6))),
                                            //背景
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent)),
                                        child: Text(
                                          Core().openedTabPageList[i],
                                          style: const TextStyle(
                                              fontFamily: 'WorkSans',
                                              letterSpacing: 0.2,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF4A6572),
                                              fontSize: 12),
                                        ),
                                        onPressed: () {
                                          String k =
                                              Core().openedTabPageList[i];

                                          Core().idControler.add(k);
                                          Core().selectedNodeName = k;
                                          Core().idControlerAction.add(k);
                                          Core().btnControler.add(k);
                                        }),
                                  ),

                                  ///关闭图标
                                  Positioned(
                                    top: -10,
                                    right: -12,
                                    child: Material(
                                        child: IconButton(
                                            color: Colors.white,
                                            onPressed: () {
                                              String k =
                                                  Core().openedTabPageList[i];
                                              Core()
                                                  .openedTabPageList
                                                  .remove(k);

                                              if (Core()
                                                  .openedTabPageList
                                                  .isNotEmpty) {
                                                k = Core().openedTabPageList[
                                                    Core()
                                                            .openedTabPageList
                                                            .length -
                                                        1];
                                                Core().selectedNodeName = k;
                                                Core().btnControler.add(k);
                                                Core().idControler.add(k);
                                                Core().idControlerAction.add(k);
                                              } else {
                                                Core().idControler.add(k);
                                                Core().idControlerAction.add(k);
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              size: 10,
                                            ))

                                        ///
                                        ),
                                  ),
                                ])
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

// import 'dart:ffi';

import 'package:flutter/material.dart';

import '../mgr.dart';
import '../../../component/utils/indexed_stack_wrapper.dart';

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
        stream: Mgr().idControler.stream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(); // const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              int currentIndex =
                  Mgr().openedTabPageList.indexOf(snapshot.data.toString());
              if (currentIndex == -1) {
                if (Mgr().openedTabPageList.isNotEmpty) {
                  currentIndex = 0;
                }
              }

              return Mgr().openedTabPageList.isEmpty
                  ? const Text('首页')
                  : Mgr().vView[snapshot.data.toString()] == null
                      ? const Text('暂时没有页面对应')
                      : IndexedStackWrapper(
                          index: currentIndex,
                          children: Mgr().openedTabPageList.map((e) {
                            return KeyedSubtree(
                                key: Key(e), child: Mgr().vView[e] as Widget);
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
        stream: Mgr().idControlerAction.stream,
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
                        for (var i = 0; i < Mgr().openedTabPageList.length; i++)
                          Container(

                              ///每个按钮限制的高度
                              height: 30.0 * 0.8,
                              margin:
                                  const EdgeInsets.only(left: 6.0, right: 6.0),
                              decoration: BoxDecoration(
                                color: Mgr().openedTabPageList[i] ==
                                        Mgr().selectedNodeName
                                    ? Mgr().selectedColor
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
                                          Mgr().openedTabPageList[i],
                                          style: const TextStyle(
                                              fontFamily: 'WorkSans',
                                              letterSpacing: 0.2,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF4A6572),
                                              fontSize: 12),
                                        ),
                                        onPressed: () {
                                          String k = Mgr().openedTabPageList[i];
                                          Mgr().idControler.add(k);
                                          Mgr().selectedNodeName = k;
                                          Mgr().idControlerAction.add(k);
                                          Mgr().colorControler.add(k);
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
                                                  Mgr().openedTabPageList[i];
                                              Mgr().openedTabPageList.remove(k);

                                              if (Mgr()
                                                      .openedTabPageList
                                                      .length >
                                                  0) {
                                                k = Mgr().openedTabPageList[
                                                    Mgr()
                                                            .openedTabPageList
                                                            .length -
                                                        1];
                                                Mgr().selectedNodeName = k;
                                                Mgr().colorControler.add(k);
                                                Mgr().idControler.add(k);
                                                Mgr().idControlerAction.add(k);
                                              } else {
                                                Mgr().idControler.add(k);
                                                Mgr().idControlerAction.add(k);
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

import 'package:flutter/material.dart';

import '../mgr.dart';
import 'indexed_stack_lazy.dart';

class Right extends StatefulWidget {
  const Right({Key? key}) : super(key: key);

  @override
  State<Right> createState() => RightState();
}

class RightState extends State<Right> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController =
        TabController(vsync: this, length: Mgr().openedTabPageList.length);
  }

  @override
  Widget build(BuildContext context) {
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        print('control change');
      }
    });
    return StreamBuilder(
        stream: Mgr().idControler.stream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              // print(Mgr().openedTabPageList.toString());
              int currentIndex =
                  Mgr().openedTabPageList.indexOf(snapshot.data.toString());
              // print('收到信息：：：' +               snapshot.data.toString() +    '   currentIndex::' +                  currentIndex.toString());
              if (currentIndex == -1) {
                if (Mgr().openedTabPageList.isNotEmpty) {
                  currentIndex = 0;
                }
              }

              return Mgr().openedTabPageList.length == 0
                  ? Container(
                      child: const Text('首页'),
                    )
                  : Mgr().vView[snapshot.data.toString()] == null
                      ? Container(
                          child: const Text('暂时没有页面对应'),
                        )
                      : Container(
                          child: Expanded(
                            child: IndexedStackLazy(
                              index: currentIndex,
                              children: Mgr().openedTabPageList.map((e) {
                                // print('准备：：：：：：：：' + e);
                                return KeyedSubtree(
                                    key: Key(e),
                                    child: Mgr().vView[e] as Widget);
                              }).toList(),
                            ),
                          ),
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

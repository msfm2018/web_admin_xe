import 'package:flutter/material.dart';

class P2 extends StatelessWidget {
  const P2({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      /// PageStorageKey 数据 状态不变化
      key: const PageStorageKey('pagekey'),
      scrollDirection: Axis.vertical,
      itemCount: 100,
      separatorBuilder: (BuildContext context, int index) => const Divider(height: 1.0, color: Colors.blue),
      itemBuilder: (BuildContext context, int index) {
        return const Column(children: <Widget>[Text('页面B', style: TextStyle(color: Colors.grey, fontSize: 26.0))]);
      },
    );
  }
}

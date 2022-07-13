import 'package:flutter/material.dart';

class P1 extends StatelessWidget {
  const P1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      /// PageStorageKey 数据 状态不变化
      key: const PageStorageKey('pagekey'),
      scrollDirection: Axis.vertical,
      itemCount: 100,
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 1.0, color: Colors.blue),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text("title $index"),
          leading: const Icon(Icons.keyboard),
          subtitle: Text("subtitle $index"),
          trailing: const Icon(Icons.keyboard_arrow_right),
          isThreeLine: false,
          dense: true,
          contentPadding: const EdgeInsets.all(10.0),
          enabled: true,
          onTap: () {},
          onLongPress: () {},
          selected: false,
        );
      },
    );
  }
}

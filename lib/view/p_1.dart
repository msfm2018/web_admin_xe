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
        return Column(
          children: <Widget>[
            // const Divider(
            //   height: 10.0,
            // ),
            ListTile(
              leading: CircleAvatar(
                foregroundColor: Theme.of(context).primaryColor,
                backgroundColor: Colors.grey,
                backgroundImage:
                    const AssetImage('assets/images/feature-1.png'),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Building a WhatsApp Clone  $index",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '12:34',
                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                ],
              ),
              subtitle: Container(
                padding: const EdgeInsets.only(top: 5.0),
                child: const Text(
                  '消息',
                  style: TextStyle(color: Colors.grey, fontSize: 15.0),
                ),
              ),
              isThreeLine: false,
              dense: true,
              contentPadding: const EdgeInsets.all(10.0),
              enabled: true,
              selected: true,
            ),
          ],
        );

        // ListTile(
        //   title: Text("title $index"),
        //   leading: const Icon(Icons.keyboard),
        //   subtitle: Text("subtitle $index"),
        //   trailing: const Icon(Icons.keyboard_arrow_right),
        //   isThreeLine: false,
        //   dense: true,
        //   contentPadding: const EdgeInsets.all(10.0),
        //   enabled: true,
        //   onTap: () {},
        //   onLongPress: () {},
        //   selected: false,
        // );
      },
    );
  }
}

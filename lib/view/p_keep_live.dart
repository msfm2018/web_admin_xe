import 'package:flutter/material.dart';

import '../common/utils/keep_alive_wrapper.dart';
import '../common/utils/utils.dart';

class KeepLive extends StatefulWidget {
  const KeepLive({Key? key}) : super(key: key);

  @override
  State<KeepLive> createState() => _KeepLiveState();
}

class _KeepLiveState extends State<KeepLive> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.red),
          gradient: GradientUtil.blue()),
      margin: const EdgeInsets.all(20),
      child: Column(children: [
        const Padding(
            padding: EdgeInsets.all(30.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.people),
                  hintText:
                      "AutomaticKeepAliveClientMixin 对于tabview页面切换有用 其它页面切换无用"),
            )),
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child: ListView.separated(
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
        ))
      ]),
    );
  }
}

class Stemp2 extends StatefulWidget {
  const Stemp2({Key? key}) : super(key: key);

  @override
  State<Stemp2> createState() => _Stemp2State();
}

class _Stemp2State extends State<Stemp2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Text('测试')],
    );
  }
}

//只在tabview 之间切换有效   AutomaticKeepAliveClientMixin
class SAreaAgeGenderMain extends StatefulWidget {
  const SAreaAgeGenderMain({Key? key}) : super(key: key);

  @override
  SAreaAgeGenderMainState createState() => SAreaAgeGenderMainState();
}

class SAreaAgeGenderMainState extends State<SAreaAgeGenderMain>
    with SingleTickerProviderStateMixin {
//
  bool isPointRadiusMapper = false;
  late List<Tab> tabList;
  late List<Widget> tabViewList;
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
    tabList = [
      const Tab(text: '页面1'),
      const Tab(text: '页面2'),
    ];
    tabViewList = [
      const KeepAliveWrapper(child: KeepLive()),
      const KeepAliveWrapper(child: Stemp2()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var tabBar = TabBar(
      isScrollable: false,
      tabs: tabList,
      indicatorColor: Colors.green,
      labelColor: Colors.black,
    );
    var result = Scaffold(
      body: DefaultTabController(
        initialIndex: 0,
        length: tabList.length,
        child: Column(
          children: [
            tabBar,
            Expanded(child: TabBarView(children: tabViewList)),
          ],
        ),
      ),
    );
    return result;
  }
}

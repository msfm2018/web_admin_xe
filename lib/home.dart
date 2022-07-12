import 'package:flutter/material.dart';
import 'package:web_admin/view/base_view/left/left.dart';

import 'view/base_view/lay_setting.dart';
import 'view/base_view/right/right.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State {
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RightState> layoutCenterKey = GlobalKey<RightState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldStateKey,
      // drawer: layoutMenu,
      endDrawer: const LaySetting(),
      body: Row(
        children: <Widget>[
          Left(),
          const VerticalDivider(
            width: 2,
            color: Colors.black12,
            thickness: 2,
          ),
          Right(key: layoutCenterKey),
        ],
      ),
      appBar: getAppBar(),
    );
  }

  // Widget _build(BuildContext context) {
  //   var layoutMenu =
  //       LayoutMenu(onClick: (Menu menu) => Utils.openTab(menu.id!));
  //   LayoutController layoutController = Get.find();
  //   var body =
  //       Utils.isMenuDisplayTypeDrawer(context) || layoutController.isMaximize
  //           ? Row(children: [LayoutCenter(key: layoutCenterKey)])
  //           : Row(
  //               children: <Widget>[
  //                 layoutMenu,
  //                 VerticalDivider(
  //                   width: 2,
  //                   color: Colors.black12,
  //                   thickness: 2,
  //                 ),
  //                 LayoutCenter(key: layoutCenterKey),
  //               ],
  //             );
  //   Scaffold subWidget = layoutController.isMaximize
  //       ? Scaffold(body: body)
  //       : Scaffold(
  //           key: scaffoldStateKey,
  //           drawer: layoutMenu,
  //           endDrawer: LayoutSetting(),
  //           body: body,
  //           appBar: getAppBar(),
  //         );
  //   return subWidget;
  // }

  getAppBar() {
    // var userInfo = StoreUtil.getCurrentUserInfo();
    // var subsystemList = StoreUtil.getSubsystemList();
    // var currentSubsystem = StoreUtil.getCurrentSubsystem();
    return AppBar(
      // backgroundColor: context.theme.primaryColor,
      automaticallyImplyLeading: false,
      leading: Tooltip(
          message: 'Menu',
          child: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              scaffoldStateKey.currentState!.openDrawer();
            },
          )),
      title: Row(children: const [
        Text('--'),
      ]),
      actions: <Widget>[
        Tooltip(
          message: 'Setting',
          child: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              scaffoldStateKey.currentState!.openEndDrawer();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PopupMenuButton(
            tooltip: 'userInfo.userName',
            onSelected: (dynamic v) {
              // if (v == 'info') {
              //   Utils.openTab('userInfoMine');
              // } else if (v == 'logout') {
              //   Utils.logout();
              //   Cry.pushNamedAndRemove('/login');
              // }
            },
            child: const Align(
              child: CircleAvatar(
                radius: 12.0,
                child: Text('aaa'),
              ),
            ),
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'info',
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text('.of(context).myInformatiSon'),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<String>(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('S.of(context).logout'),
                ),
              ),
            ],
          ),
        ),
        PopupMenuButton(
          onSelected: (dynamic v) {
            switch (v) {
              case 'code':
                //  Utils.launchURL("https://github.com/cairuoyu/flutter_admin");
                break;
              case 'android':
                break;
              case 'about':
                break;
              case 'feedback':
                break;
              case 'privacy':
                // var privacy = ApplicationContext.instance.privacy;
                // cryAlert(context, privacy);
                break;
            }
          },
          itemBuilder: (context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'code',
              child: ListTile(
                leading: Icon(Icons.code),
                title: Text('源码'),
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<String>(
              value: 'android',
              child: ListTile(
                leading: Icon(Icons.android),
                title: Text('android'),
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<String>(
              value: 'feedback',
              child: ListTile(
                leading: Icon(Icons.feedback),
                title: Text('反馈'),
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<String>(
              value: 'about',
              child: ListTile(
                leading: Icon(Icons.vertical_split),
                title: Text('关于'),
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<String>(
              value: 'privacy',
              child: ListTile(
                leading: Icon(Icons.privacy_tip),
                title: Text('隐私'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

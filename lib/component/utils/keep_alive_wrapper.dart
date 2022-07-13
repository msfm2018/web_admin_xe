// 页面状态存储  tabbar tabview

import 'package:flutter/material.dart';

class KeepAliveWrapper extends StatefulWidget {
  final Widget? child;

  const KeepAliveWrapper({Key? key, this.child}) : super(key: key);

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

/// 数据保活机制
class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    print(widget.child!.toStringShort() + '--initState');
    super.initState();
  }

  @override
  void dispose() {
    print(widget.child!.toStringShort() + '--disponse');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.child!.toStringShort() + '--build');
    super.build(context);
    return widget.child!;
  }

  @override
  bool get wantKeepAlive => true;
}

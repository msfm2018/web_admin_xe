// 页面状态存储  tabbar tabview

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class KeepAliveWrapper extends StatefulWidget {
  final Widget? child;

  const KeepAliveWrapper({Key? key, this.child}) : super(key: key);

  @override
  KeepAliveWrapperState createState() => KeepAliveWrapperState();
}

/// 数据保活机制
class KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    if (kDebugMode) {
      print('${widget.child!.toStringShort()}--initState');
    }
    super.initState();
  }

  @override
  void dispose() {
    if (kDebugMode) {
      print('${widget.child!.toStringShort()}--disponse');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('${widget.child!.toStringShort()}--build');
    }
    super.build(context);
    return widget.child!;
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';

import 'left_items/left.dart';
import 'right_inspect/right.dart';

class TreeWidget extends StatelessWidget {
  const TreeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // 平板屏幕，显示两个页面
          return const Row(
            children: <Widget>[
              Left(),
              VerticalDivider(
                width: 2,
                color: Colors.black12,
                thickness: 2,
              ),
              Right(),
            ],
          );
        } else {
          // 手机屏幕，只显示一个页面
          return const Row(
            children: [
              Right(),
            ],
          );
        }
      },
    );
  }
}

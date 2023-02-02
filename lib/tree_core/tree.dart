import 'package:flutter/material.dart';

import 'left_items/left.dart';
import 'right_inspect/right.dart';

class TreeWidget extends StatelessWidget {
  const TreeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        Left(),
        VerticalDivider(
          width: 2,
          color: Colors.black12,
          thickness: 2,
        ),
        Right(),
      ],
    );
  }
}

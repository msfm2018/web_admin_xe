import 'package:flutter/material.dart';
import 'left.dart';
import 'right.dart';
import 'data.dart';

class TreeWidget extends StatelessWidget {
  final List<TreeData> data;
  const TreeWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return Row(children: <Widget>[if (isTablet) Left(data: data), if (isTablet) const VerticalDivider(width: 2, color: Colors.black12, thickness: 2), const Expanded(child: Right())]);
  }
}

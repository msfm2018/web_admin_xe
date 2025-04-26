import 'package:flutter/material.dart';
import 'left_item.dart';
import 'data.dart';

class MultiNamePage extends StatefulWidget {
  final List<TreeData>? data; //  使用 TreeData
  const MultiNamePage({super.key, this.data});

  @override
  MultiItemPageState createState() => MultiItemPageState();
}

class MultiItemPageState extends State<MultiNamePage> {
  @override
  Widget build(BuildContext context) {
    final List<TreeData> displayData = widget.data ?? [];
    return ListView.builder(
      itemCount: displayData.length,
      itemBuilder: (BuildContext context, int index) {
        return ItemPage(displayData[index]);
      },
    );
  }
}

class Left extends StatefulWidget {
  final List<TreeData>? data;
  const Left({super.key, this.data});

  @override
  State<Left> createState() => LeftState();
}

class LeftState extends State<Left> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width * 1 / 8 < 266 ? 266 : MediaQuery.of(context).size.width * 1 / 7;
    return SizedBox(width: w, child: MultiNamePage(data: widget.data));
  }
}

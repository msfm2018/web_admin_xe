import 'package:flutter/material.dart';
import 'item_page.dart';
import '../../tree_config/data_bean.dart';

class MultiNamePage extends StatefulWidget {
  const MultiNamePage({Key? key}) : super(key: key);

  @override
  MultiItemPageState createState() => MultiItemPageState();
}

class MultiItemPageState extends State<MultiNamePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return ItemPage(data[index]);
      },
    );
  }
}

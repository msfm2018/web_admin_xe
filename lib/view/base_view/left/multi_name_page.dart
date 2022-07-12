import 'package:flutter/material.dart';
import 'name_item_widget.dart';
import '../name_bean.dart';

class MultiNamePage extends StatefulWidget {
  const MultiNamePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MultiNamePageState createState() => _MultiNamePageState();
}

class _MultiNamePageState extends State<MultiNamePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // 长度
      itemCount: data.length,

      // 遍历
      itemBuilder: (BuildContext context, int index) {
        return NameItemWidget(data[index]);
      },
    );
  }
}

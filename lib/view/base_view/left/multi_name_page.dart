import 'package:flutter/material.dart';
import 'name_item_widget.dart';
import '../../../view_config/name_bean.dart';

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
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return NameItemWidget(data[index]);
      },
    );
  }
}

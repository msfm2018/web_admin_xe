import 'package:flutter/material.dart';

import 'multi_name_page.dart';

class Left extends StatefulWidget {
  const Left({Key? key}) : super(key: key);

  @override
  State<Left> createState() => LeftState();
}

class LeftState extends State<Left> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width * 1 / 8 < 266
        ? 266
        : MediaQuery.of(context).size.width * 1 / 7;
    return SizedBox(width: w, child: const MultiNamePage());
  }
}

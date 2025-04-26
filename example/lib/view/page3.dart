import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class P3Data {
  var myTitle = 'mytitile';
  int i = 0;
}

class Page3 extends StatefulWidget {
  Page3({super.key});

  // String name = '';

  @override
  P3State createState() => P3State();
}

class P3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40),
          child: const Text(
            '系统方法',
            style: TextStyle(
              // color: AppColors.primaryText,
              fontFamily: "Avenir",
              fontWeight: FontWeight.bold,
              fontSize: 32,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}

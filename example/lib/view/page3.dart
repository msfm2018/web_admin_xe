import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

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

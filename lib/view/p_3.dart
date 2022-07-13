import 'dart:async';

import 'package:flutter/material.dart';

import '../component/values/colors.dart';

class P3Data {
  var myTitle = 'mytitile';
  int i = 0;
}

class P3 extends StatefulWidget {
  P3(this.name, {this.key}) : super(key: key);

  String name = '';

  Key? key;

  @override
  State<P3> createState() => _P3State();
}

class _P3State extends State<P3> {
  StreamController<String> ss = StreamController();
  P3Data? p3_data;
  @override
  void dispose() {
    ss.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    var tt =
        PageStorage.of(context)!.readState(context, identifier: widget.key);
    if (tt != null) {
      p3_data = tt;
    } else {
      p3_data = P3Data();
    }
    super.didChangeDependencies();
  }

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
              color: AppColors.primaryText,
              fontFamily: "Avenir",
              fontWeight: FontWeight.bold,
              fontSize: 32,
              height: 1.3,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          alignment: Alignment.topCenter,
          height: 400,
          width: MediaQuery.of(context).size.width / 2,
          // decoration:              BoxDecoration(border: Border.all(width: 1, color: Colors.red)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StreamBuilder(
                  stream: ss.stream,
                  initialData: '---',
                  builder: (context, snapshot) {
                    return Text(p3_data == null ? "" : p3_data!.myTitle);
                    //  return Text(m(widget.name) == null ? "" : m(widget.name).myTitle);
                  }),
              const SizedBox(
                width: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  ///框架自带方法 数据持久化
                  // m(widget.name).myTitle = '值:' + m(widget.name).i.toString() + '';

                  // ss.add(m(widget.name).myTitle);

                  //m(widget.name).i++;

                  ///系统自带方法数据持久化
                  p3_data!.myTitle = "我CAO " + p3_data!.i.toString();

                  p3_data!.i++;
                  ss.add(p3_data!.myTitle);

                  PageStorage.of(context)!
                      .writeState(context, p3_data, identifier: widget.key);
                },
                child: const Text('测试页面切换数据持久化'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.hovered)) {
                      return const Color.fromARGB(255, 41, 103, 255);
                    }
                    return const Color.fromARGB(155, 41, 103, 255);
                  }),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        MaterialButton(
          onPressed: btnState(false),
          disabledColor: Colors.grey,
          color: Colors.red,
          child: Text('禁用按钮'),
        ),
      ],
    );
  }

  btnState(f) {
    if (f) {
      return () {
        print("you");
      };
    } else {
      print('空');
      return null;
    }
  }
}

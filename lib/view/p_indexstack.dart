import 'package:flutter/material.dart';

class TestIndexStack extends StatefulWidget {
  const TestIndexStack({Key? key}) : super(key: key);

  @override
  State<TestIndexStack> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TestIndexStack> {
  var lst = <Widget>[];
  int i = 0;
  @override
  void initState() {
    super.initState();

    lst.addAll([f1(), f2(), f3()]);
  }

  getW(ix) {
    return IndexedStack(index: ix, children: lst);
  }

  void _incrementCounter() {
    lst.clear();
    lst.addAll([f1(), f2(), f3()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            getW(i),
            Container(
              height: 1,
              color: Colors.orange,
            ),
            ElevatedButton(
                onPressed: () {
                  i = 0;

                  setState(() {});
                },
                child: Text('f1')),
            ElevatedButton(
                onPressed: () {
                  i = 1;

                  setState(() {});
                },
                child: Text('f2')),
            ElevatedButton(
                onPressed: () {
                  i = 2;

                  setState(() {});
                },
                child: Text('f3')),
            ElevatedButton(
                onPressed: () {
                  // lst.remove(f2());
                  lst.removeAt(1);

                  setState(() {});
                },
                child: Text('del f2')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) => const MyWidget()));
                },
                child: Text('页面跳转')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Text('重置'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class f1 extends StatefulWidget {
  const f1({Key? key}) : super(key: key);

  @override
  State<f1> createState() => _f1State();
}

class _f1State extends State<f1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text("f1 页面"),
          SizedBox(
            height: 30,
          ),
          TextField(
            autofocus: true,
            cursorColor: Colors.black,
            cursorWidth: 2,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              // icon: Icon(Icons.person),
              hintText: 'f1观察页面跳转 返回数据有无变化',
              suffixIcon: IconButton(
                ///跳过焦点
                focusNode: FocusNode(skipTraversal: true),
                icon: const Icon(Icons.close),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}

class f2 extends StatefulWidget {
  const f2({Key? key}) : super(key: key);

  @override
  State<f2> createState() => _f2State();
}

class _f2State extends State<f2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text("f2 页面"),
          SizedBox(
            height: 30,
          ),
          TextField(
            autofocus: true,
            cursorColor: Colors.black,
            cursorWidth: 2,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              // icon: Icon(Icons.person),
              hintText: 'f2观察页面跳转 返回数据有无变化',
              suffixIcon: IconButton(
                ///跳过焦点
                focusNode: FocusNode(skipTraversal: true),
                icon: const Icon(Icons.close),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}

class f3 extends StatefulWidget {
  const f3({Key? key}) : super(key: key);

  @override
  State<f3> createState() => _f3State();
}

class _f3State extends State<f3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text("f3 页面"),
          SizedBox(
            height: 30,
          ),
          TextField(
            autofocus: true,
            cursorColor: Colors.black,
            cursorWidth: 2,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              // icon: Icon(Icons.person),
              hintText: 'f3观察页面跳转 返回数据有无变化',
              suffixIcon: IconButton(
                ///跳过焦点
                focusNode: FocusNode(skipTraversal: true),
                icon: const Icon(Icons.close),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyHomePageState1();
}

class _MyHomePageState1 extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Text('data'),
            Text('data1'),
            Text('data2'),
            Text('data3'),
            Text('data4'),
            Text('data5'),
            Text('data6'),
          ],
        ));
  }
}

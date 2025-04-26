import 'package:flutter/material.dart';

class TestIndexStack extends StatefulWidget {
  const TestIndexStack({super.key});

  @override
  State<TestIndexStack> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TestIndexStack> {
  var lst = <Widget>[];
  int i = 0;
  @override
  void initState() {
    super.initState();

    lst.addAll(const [F1(), F2(), F3()]);
  }

  getW(ix) {
    return IndexedStack(index: ix, children: lst);
  }

  void _incrementCounter() {
    lst.clear();
    lst.addAll(const [F1(), F2(), F3()]);
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
                child: const Text('F1')),
            ElevatedButton(
                onPressed: () {
                  i = 1;

                  setState(() {});
                },
                child: const Text('F2')),
            ElevatedButton(
                onPressed: () {
                  i = 2;

                  setState(() {});
                },
                child: const Text('F3')),
            ElevatedButton(
                onPressed: () {
                  // lst.remove(F2());
                  lst.removeAt(1);

                  setState(() {});
                },
                child: const Text('del F2')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => const MyWidget()));
                },
                child: const Text('页面跳转')),
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

class F1 extends StatefulWidget {
  const F1({super.key});

  @override
  State<F1> createState() => _F1State();
}

class _F1State extends State<F1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      alignment: Alignment.center,
      child: Column(
        children: [
          const Text("F1 页面"),
          const SizedBox(
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
              hintText: 'F1观察页面跳转 返回数据有无变化',
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

class F2 extends StatefulWidget {
  const F2({super.key});

  @override
  State<F2> createState() => _F2State();
}

class _F2State extends State<F2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      alignment: Alignment.center,
      child: Column(
        children: [
          const Text("F2 页面"),
          const SizedBox(
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
              hintText: 'F2观察页面跳转 返回数据有无变化',
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

class F3 extends StatefulWidget {
  const F3({super.key});

  @override
  State<F3> createState() => _F3State();
}

class _F3State extends State<F3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      alignment: Alignment.center,
      child: Column(
        children: [
          const Text("F3 页面"),
          const SizedBox(
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
              hintText: 'F3观察页面跳转 返回数据有无变化',
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
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyHomePageState1();
}

class _MyHomePageState1 extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const Column(
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

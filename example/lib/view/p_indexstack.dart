import 'package:flutter/material.dart';

class TestIndexStack extends StatefulWidget {
  const TestIndexStack({super.key});

  @override
  State<TestIndexStack> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TestIndexStack> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("data")));
  }
}

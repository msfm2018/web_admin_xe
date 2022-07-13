import 'package:flutter/material.dart';

class IndexedStackWrapper extends StatefulWidget {
  final int index;
  final List<Widget> children;

  IndexedStackWrapper({Key? key, this.index = 0, required this.children})
      : super(key: key);

  @override
  _IndexedStackWrapperState createState() => _IndexedStackWrapperState();
}

class _IndexedStackWrapperState extends State<IndexedStackWrapper> {
  List<Widget> children = <Widget>[];
  int index = 0;

  @override
  void initState() {
    children.add(widget.children[widget.index]);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant IndexedStackWrapper oldWidget) {
    List<Widget> newChildren = <Widget>[];
    for (int i = 0; i < widget.children.length; i++) {
      var w = widget.children[i];
      var existIndex = children.indexWhere((element) => element.key == w.key);

      if (existIndex > -1) {
        newChildren.add(children[existIndex]);
        if (widget.index == i) {
          index = newChildren.length - 1;
        }
      } else if (widget.index == i) {
        newChildren.add(w);
        index = newChildren.length - 1;
      }
    }
    children = newChildren;
    print('IndexedStack状态：：' + children.toString());
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: children,
    );
  }
}

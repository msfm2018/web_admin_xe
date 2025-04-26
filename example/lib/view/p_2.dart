import 'package:flutter/material.dart';
// Flutter中提供了一些剪裁widget，如下表格。

// widget	作用
// ClipRect	将 child 剪裁为给定的矩形大小
// ClipRRect	将 child 剪裁为圆角矩形
// ClipOval	如果 child 为正方形时剪裁之后是圆形，如果 child 为矩形时，剪裁之后为椭圆形
// ClipPath	将 child 按照给定的路径进行裁剪
// CustomClipper	并不是一个widget，但是使用CustomClipper可以绘制出任何我们想要的形状

class P2 extends StatelessWidget {
  const P2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Colors.orange, Colors.red],
          stops: <double>[0.0, 1.0],
        ),
      ),
      child: SingleChildScrollView(child: renderCover()), // const Center(child: Text('页面P2')),
    );
  }

  Widget renderCover() {
    return const Column(
      children: <Widget>[
        Text('页面B', style: TextStyle(color: Colors.grey, fontSize: 26.0)),
      ],
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  MyClipper({Key? key});
  @override
  Rect getClip(Size size) {
    return const Rect.fromLTRB(100, 1010, 200, 200);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}

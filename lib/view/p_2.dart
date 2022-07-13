import 'package:flutter/material.dart';
// Flutter中提供了一些剪裁widget，如下表格。

// widget	作用
// ClipRect	将 child 剪裁为给定的矩形大小
// ClipRRect	将 child 剪裁为圆角矩形
// ClipOval	如果 child 为正方形时剪裁之后是圆形，如果 child 为矩形时，剪裁之后为椭圆形
// ClipPath	将 child 按照给定的路径进行裁剪
// CustomClipper	并不是一个widget，但是使用CustomClipper可以绘制出任何我们想要的形状

class P2 extends StatelessWidget {
  const P2({Key? key}) : super(key: key);

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
      child: SingleChildScrollView(
          child: renderCover()), // const Center(child: Text('页面P2')),
    );
  }

  Widget renderCover() {
    return Column(
      children: <Widget>[
        ClipRect(
            //裁剪出来的是矩形
            child: SizedBox(
                height: 150,
                width: 150,
                child: Image.network(
                  'https://scpic2.chinaz.net/Files/pic/pic9/202207/apic41968_s.jpg',
                  fit: BoxFit.cover,
                ))),

        // // AssetImage(assetName)//不是小部件
        // //  NetworkImage 不是小部件   CircleAvatar  FadeInImage :NetworkImage
        // //  Image.network 小部件
        // // Image.asset  //小部件
        ClipRRect(
            //裁剪出来的是矩形
            borderRadius: BorderRadius.circular(20),
            child: Container(
                height: 150,
                width: 150,
                child: Image.network(
                  'https://scpic2.chinaz.net/Files/pic/pic9/202207/apic41968_s.jpg',
                  fit: BoxFit.cover,
                ))),
        // ClipRRect圆角矩形
        ClipRRect(
            //裁剪出来的是矩形
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              width: 160,
              height: 160,
              fit: BoxFit.contain,
              image: NetworkImage(
                  'https://img0.baidu.com/it/u=3828415487,808710726&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500'),
              placeholder: AssetImage('assets/images/bg.png'),
            )),

        ClipOval(
          clipper: MyClipper(), //设置大小 圆形或者椭圆形。
          //图片占位
          child: const FadeInImage(
            fit: BoxFit.fitHeight,
            image: NetworkImage(
                'https://img0.baidu.com/it/u=3828415487,808710726&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500'),
            placeholder: AssetImage('assets/images/bg.png'),
          ),
        ),
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

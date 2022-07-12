import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import '../../home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Example3State createState() => _Example3State();
}

class _Example3State extends State<Login> {
  var isLogin = false;
  var rocketBottom = -80.0;
  var rocketWidth = 160.0;
  var f = false;

  var btnEnabled = false;
  FocusScopeNode node = FocusScopeNode();

  ///

  var controller1 = TextEditingController();
  var controller2 = TextEditingController();
  @override
  void initState() {
    super.initState();
    //  WidgetsBinding.instance.addPostFrameCallback((_) => );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.linearToSrgbGamma(),
                    image: AssetImage('assets/images/bg.jpg')

                    ///
                    )),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: jmpScaffold(context, Colors.transparent))));
  }

  Scaffold jmpScaffold(BuildContext context, Color? co) {
    Future.delayed(const Duration(seconds: 1), () {
      if (!f) {
        setState(() {
          rocketBottom = MediaQuery.of(context).size.height + 110;
          rocketWidth = 40.0;
          f = true;
        });
      }
    });

    return Scaffold(
      backgroundColor: co,
      // appBar: AppBar(),
      body: Center(
        child: FocusScope(
          node: node,
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    AnimatedPositioned(
                      bottom: rocketBottom,
                      width: rocketWidth,
                      duration: const Duration(seconds: 10),
                      curve: Curves.easeInCubic,
                      child: Image.asset(
                        'assets/images/rocket.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),

                    ///约束
                    SizedBox(
                      width: 800,
                      // height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  autofocus: true,
                                  controller: controller1,
                                  cursorColor: Colors.white,
                                  cursorWidth: 2,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    // icon: Icon(Icons.person),
                                    hintText: '请输入账号',
                                    suffixIcon: IconButton(
                                      ///跳过焦点
                                      focusNode: FocusNode(skipTraversal: true),
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        controller1.clear();
                                      },
                                    ),
                                  ),
                                  onEditingComplete: onEdit,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  controller: controller2,
                                  // decoration:null 无边框
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    hintText: '请输入密码',
                                    suffixIcon: IconButton(
                                      focusNode: FocusNode(skipTraversal: true),
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        controller2.clear();
                                      },
                                    ),
                                  ),
                                  maxLength: 18,
                                  cursorColor: Colors.white,
                                  cursorWidth: 2,
                                  obscureText: true,
                                  onEditingComplete: onEdit,
                                ),
                              ),
                            ],
                          ), //Future.microtask
                          FlutterPwValidator(
                            controller: controller2,
                            minLength: 8,
                            uppercaseCharCount: 2,
                            numericCharCount: 3,
                            // specialCharCount: 1,
                            normalCharCount: 3,
                            width: 400,
                            height: 150,
                            onSuccess: () {
                              //点击登陆打印username.text的值即可
                              showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("提示"),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: const <Widget>[
                                          Text('密码正确'),
                                          Text('可以登录'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('确定'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ).then((val) {
                                // print(val);
                              });
                              btnEnabled = true;
                              setState(() {});
                              // print("MATCHED");
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //     new SnackBar(
                              //         content:
                              //             new Text("Password is matched")));
                            },
                            onFail: () {
                              btnEnabled = false;
                              // print("NOT MATCHED");
                            },
                          ),
                          Container(
                            height: 360,
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: 420,
                              child: TextButton(
                                onPressed: btnState(btnEnabled),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    if (states
                                        .contains(MaterialState.hovered)) {
                                      return const Color.fromARGB(
                                          255, 41, 103, 255);
                                    }
                                    return const Color.fromARGB(
                                        155, 41, 103, 255);
                                  }),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0)),
                                  ),
                                ),
                                child: const Text('登录',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 20)),
                              ),
                            ),
                          ),

                          if (isLogin) const CircularProgressIndicator()
                        ],
                      ),
                    ),
                    // Positioned(
                    //     top: -60,
                    //     child: Container(
                    //       width: 300,
                    //       height: 200,
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: const <Widget>[
                    //           CircleAvatar(
                    //               radius: 40.0,
                    //               backgroundColor: Colors.transparent,
                    //               child: Image(
                    //                 image: AssetImage(
                    //                     'assets/images/feature-1.png'),
                    //                 fit: BoxFit.fill,
                    //               ) // Icon(Icons.person),
                    //               ),
                    //         ],
                    //       ),
                    //     )),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  onEdit() {
    node.nextFocus();
  }

  btnState(f) {
    if (f) {
      return () {
        if ((controller1.value.text == "") || (controller2.value.text == "")) {
          node.nextFocus();
        } else {
          isLogin = true;
          setState(() {});
          Future(
            () {
              Future.delayed(const Duration(seconds: 1), () {
                isLogin = false;
                Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => const Home()),
                  ModalRoute.withName('/'),
                );
                setState(() {});
              });
            },
          );
        }
      };
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    node.dispose();
  }
}

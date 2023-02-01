import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  var isLogin = false;
  var f = false;

  var btnEnabled = false;
  FocusScopeNode node = FocusScopeNode();

  var controller1 = TextEditingController();
  var controller2 = TextEditingController();

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
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Center(
                    child: FocusScope(
                      node: node,
                      child: SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                SizedBox(
                                  width: 800,
                                  //  height: MediaQuery.of(context).size.height,
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
                                                border:
                                                    const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                // icon: Icon(Icons.person),
                                                hintText: '请输入账号',
                                                suffixIcon: IconButton(
                                                  focusNode: FocusNode(
                                                      skipTraversal: true),
                                                  icon: const Icon(Icons.close),
                                                  onPressed: () {
                                                    controller1.clear();
                                                  },
                                                ),
                                              ),
                                              onEditingComplete: () =>
                                                  node.nextFocus(),
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
                                                border:
                                                    const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                hintText: '请输入密码',
                                                suffixIcon: IconButton(
                                                  focusNode: FocusNode(
                                                      skipTraversal: true),
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
                                              onEditingComplete: () =>
                                                  node.nextFocus(),
                                            ),
                                          ),
                                        ],
                                      ), //Future.microtask
                                      //三方控件
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
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(const SnackBar(
                                          //         content: Text("ok")));
                                          btnEnabled = true;
                                          setState(() {});
                                        },
                                        onFail: () {
                                          btnEnabled = false;
                                        },
                                      ),
                                      Container(
                                        height: 360,
                                        alignment: Alignment.bottomCenter,
                                        child: SizedBox(
                                          width: 420,
                                          height: 50,
                                          child: TextButton(
                                            onPressed: btnState(btnEnabled),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith((states) {
                                                if (states.contains(
                                                    MaterialState.hovered)) {
                                                  return const Color.fromARGB(
                                                      255, 41, 103, 255);
                                                }
                                                return const Color.fromARGB(
                                                    155, 41, 103, 255);
                                              }),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0)),
                                              ),
                                            ),
                                            child: const Text('登录',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontFamily: "Avenir",
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 20)),
                                          ),
                                        ),
                                      ),

                                      if (isLogin)
                                        const CircularProgressIndicator()
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                ))));
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

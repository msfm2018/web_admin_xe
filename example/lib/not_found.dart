import 'package:flutter/cupertino.dart';

class NotFound extends StatefulWidget {
  const NotFound({super.key});

  @override
  State<NotFound> createState() => _NoFoundState();
}

class _NoFoundState extends State<NotFound> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('页面丢失'),
    );
  }
}

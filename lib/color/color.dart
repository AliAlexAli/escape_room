import 'package:flutter/material.dart';

class FullScreenColor extends StatelessWidget {
  final Color color;

  const FullScreenColor({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox.expand(),
      ),
    );
  }
}
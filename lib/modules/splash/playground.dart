import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Playground extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Playground> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PLAYGROUND"),
      ),
      body: CustomPaint(
        size: Size(
            MediaQuery.of(context).size.width,
            (MediaQuery.of(context).size.width * 0.16319444444444445)
                .toDouble()),
      ).marginOnly(top: 100),
    );
  }
}

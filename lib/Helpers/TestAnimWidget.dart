/*

import 'package:flutter/material.dart';

class TestAnimWidget extends StatefulWidget {
  final Widget child;

  const TestAnimWidget({Key key, this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TestAnimWidgetState();
}

class TestAnimWidgetState extends State<TestAnimWidget>
    with SingleTickerProviderStateMixin {
  final TextEditingController textController = TextEditingController();
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            }
          });

    return AnimatedBuilder(
        animation: offsetAnimation,
        builder: (buildContext, child) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 24.0),
            padding: EdgeInsets.only(
                left: offsetAnimation.value + 24.0,
                right: 24.0 - offsetAnimation.value),
            child: widget.child,
          );
        });
  }

  Future<void> startAnimation() async {
    await controller.forward(from: 0.0);
    return;
  }

  void stopAnimation() {
    controller.reset();
  }
}
*/

import 'package:flutter/material.dart';

class TabContainer extends StatefulWidget {
  final List<Widget> children;

  const TabContainer({
    required Key key,
    required this.children,
  }) : super(key: key);

  @override
  TabContainerState createState() => TabContainerState();
}

class TabContainerState extends State<TabContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int index = 0;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 100,
        ));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: widget.children,
    );
  }

  void changeIndex(int index) {
    if (mounted) {
      setState(() {
        this.index = index;
        _controller.forward(from: 0);
      });
    }
  }
}

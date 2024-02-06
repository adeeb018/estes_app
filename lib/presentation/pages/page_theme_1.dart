import 'package:flutter/material.dart';
class PageThemeOne extends StatelessWidget {
  const PageThemeOne({super.key, required this.currentView});

  final int currentView;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _rotatingContainer(currentView),
        Image.asset("assets/images/rocket_1.png"),
      ],
    );
  }

  Builder _rotatingContainer(int pos) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          color: Colors.black,
          child: AnimatedRotation(
            turns: pos / 4,
            duration: const Duration(seconds: 2),
            child: Image.asset("assets/images/group_1.png"),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class CorousalText extends StatelessWidget {
  const CorousalText({super.key,required this.text,required this.color});

  final String text;
  // final String fontFamily;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle(),
      textAlign: TextAlign.center,
    );
  }
  TextStyle textStyle() {
    return TextStyle(
        color: color,
        // fontFamily: fontFamily,
        fontSize: 20.0,
        fontWeight: FontWeight.w700);
  }
}

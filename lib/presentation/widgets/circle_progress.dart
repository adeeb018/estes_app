import 'dart:math';

import 'package:flutter/material.dart';

class CircleProgress extends CustomPainter{

  final strokeCircle = 8.0;
  double currentProgress;
  CircleProgress(this.currentProgress);
  @override

  late Color drawColor;
  void paint(Canvas canvas, Size size) {
    double val = currentProgress/20.round();

    if(val < 3.0){
      drawColor = Colors.yellow;
    }
    else if(val <= 4.0){
      drawColor = Colors.orange;
    }
    else{
      drawColor = Colors.green;
    }

    Paint circle = Paint()
        ..strokeWidth = strokeCircle
        ..color = Colors.grey
        ..style = PaintingStyle.stroke;

    Offset center = Offset((size.width/2), size.height/2);
    double radius = 150;
    canvas.drawCircle(center, radius, circle);
    
    
    Paint animationArc = Paint()
    ..strokeWidth = strokeCircle
    ..color = drawColor
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
    
    double angle = 2 * pi * (currentProgress/100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi/2, angle, false,
    animationArc);

  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
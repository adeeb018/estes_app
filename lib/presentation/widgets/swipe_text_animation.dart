import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
class SwipeTextAnimation extends StatefulWidget {
  const SwipeTextAnimation({super.key,required this.text,this.linearGradient});

  final Shader? linearGradient;
  final String text;
  @override
  TextAnimation createState() => TextAnimation();
}

class TextAnimation extends State<SwipeTextAnimation> with TickerProviderStateMixin {

  StoreController storeController = Get.find<StoreController>();
  late AnimationController _controller;
  late Animation<double> _positionAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    // Initialize the position animation
    _positionAnimation = Tween<double>(
      begin: 0.0,
      end: 3.0, // Change end to 2.0 to ensure the second half of the animation
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0, 1, curve: Curves.linear),
    ));

    // Set the animation to repeat forever
    _controller.repeat();

    // Uncomment the line below to play the animation only once
    // _controller.forward();
  }

  @override
  void dispose() {
    // Dispose the animation controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String text = widget.text;

    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [Colors.blue, Colors.white, Colors.blue],
                stops: [
                  _positionAnimation.value,
                  _positionAnimation.value,
                  1.0, // Ensure white at the end
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: storeController.currentFont.value,
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      );
  }
}
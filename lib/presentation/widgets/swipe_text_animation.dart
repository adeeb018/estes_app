import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SwipeTextAnimation extends StatefulWidget {
  const SwipeTextAnimation({super.key,required this.text,this.linearGradient});

  final Shader? linearGradient;
  final String text;
  @override
  TextAnimation createState() => TextAnimation();
}

class TextAnimation extends State<SwipeTextAnimation> with TickerProviderStateMixin {

  final StoreController storeController = Get.find<StoreController>();
  late AnimationController _controller;
  late Animation<double> _positionAnimation;
  late Animation _secondPositionAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );


    _secondPositionAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem(
      tween: ColorTween(begin: Colors.blue[50],end: Colors.blue[700]),
      weight: 99,
    ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.blue[700],end: Colors.white),
        weight: 1,

      ),
    ]).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1, curve: Curves.linear),
      ));

    // Initialize the position animation
    _positionAnimation = Tween<double>(
      begin: 0.0,
      end: 2.0, // Change end to 2.0 to ensure the second half of the animation
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 1, curve: Curves.easeInQuart),
    ));
      _controller.repeat();
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
                colors: [_secondPositionAnimation.value,Colors.white],
                stops: [
                  _positionAnimation.value,
                  _positionAnimation.value, // Ensure white at the end
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
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
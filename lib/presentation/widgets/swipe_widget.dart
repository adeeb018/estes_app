import 'package:estes_app/presentation/pages/launch_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:get/get.dart';

class SwipeWidget extends StatelessWidget {
   const SwipeWidget({
    super.key,
    required this.context,
    // required this.currentFont,
    required this.linearGradient,
    required this.swipeText,required this.onSwipe
  });

  final BuildContext context;
  // final String currentFont;
  final Shader linearGradient;
  final String swipeText;

  final void Function()? onSwipe;


  @override
  Widget build(BuildContext context) {
    return SwipeButton(
      width: MediaQuery.of(context).size.width * 0.9,
      thumb: Image.asset('assets/images/swipe_image.png'),
      // activeThumbColor: Colors.blue,
      borderRadius: BorderRadius.circular(20),
      activeTrackColor: Colors.black,
      activeThumbColor: Colors.blue,
      // activeThumbColor: const Color.fromARGB(41,85,218,111),

      height: 70.0,
      onSwipe: (){
        if(swipeText == 'Swipe to Ready') {
          onSwipe!();
        } else{
          // route to launch screen
          Get.to(() => const LaunchRocket());
        }
        },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.16,
        // padding: EdgeInsets.only(left: 60.0,top: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border:Border.all(color: Colors.blue,width: 2.0),
        ),
        child: Center(
          child: Text(
            swipeText,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              foreground: Paint()..shader = linearGradient,
            ),
          ),
        ),
      ),
    );
  }
}

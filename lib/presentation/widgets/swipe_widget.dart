import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:estes_app/presentation/pages/launch_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:get/get.dart';

class SwipeWidget extends StatelessWidget {
   SwipeWidget({
    super.key,
    required this.context,
    required this.linearGradient,
    required this.swipeText,required this.onSwipe,
  });

  final BuildContext context;
  // final String currentFont;
  final Shader linearGradient;
  final String swipeText;

  final StoreController storeController = Get.find<StoreController>();

  final void Function()? onSwipe;


  @override
  Widget build(BuildContext context) {
    return Obx(() => SwipeButton(
      width: MediaQuery.of(context).size.width * 0.9,
      thumb: thumbImageOrIcon(),
      // activeThumbColor: Colors.blue,
      borderRadius: storeController.currentTheme.value == 1?BorderRadius.circular(20):BorderRadius.circular(15),
      activeTrackColor: Colors.transparent,
      activeThumbColor: activeThemeThumbColor(),
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
      // this container contains swipe to ready rectangle
      child: Container(
        width: MediaQuery.of(context).size.width * 0.87,
        height: MediaQuery.of(context).size.width * 0.16,
        // padding: EdgeInsets.only(left: 60.0,top: 12.0),
        decoration: BoxDecoration(
          color: storeController.currentTheme.value == 2?Color.fromRGBO(0, 0, 0, 0.7):Color.fromRGBO(0, 0, 0, 0.4),
          borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15)),
          border: storeController.currentTheme.value == 1?Border.all(color: Colors.blue,width: 2.0):Border.all(color: Colors.transparent),
            // BorderSide(color: Colors.white, width: 2.0):BorderSide(color: Colors.transparent)
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
              // .animate().slideX(duration: Duration(seconds: 2)),
        ),
      ),
    ));
  }

  /*
  here it returns the slider image or icon for specific theme
   */
  Widget thumbImageOrIcon(){
    if(storeController.currentTheme.value == 1){
      return Image.asset('assets/images/swipe_image.png');
    }
    else{
      return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 7,color: Colors.black)
          ),
          child: Icon(Icons.arrow_forward_ios_rounded,size: 40,color: Colors.black,));
    }
  }

  /*
  this returns the swipe container background color
   */
  Color activeThemeThumbColor(){
    if(storeController.currentTheme.value == 1){
      return Colors.blue;
    }
    else{
      return Colors.transparent;
    }
  }
}

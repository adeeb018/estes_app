import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:estes_app/presentation/pages/launch_screen.dart';
import 'package:estes_app/presentation/widgets/swipe_text_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:get/get.dart';

class SwipeWidget extends StatelessWidget {
   SwipeWidget({
    super.key,
    required this.context,
    required this.swipeText,required this.onSwipe,
  });

  final BuildContext context;

  final String swipeText;

  final StoreController storeController = Get.find<StoreController>();

  final void Function()? onSwipe;


  @override
  Widget build(BuildContext context) {
    return Obx(() => SwipeButton(
      width: MediaQuery.of(context).size.width * 0.9,
      thumb: _thumbImageOrIcon(),
      // activeThumbColor: Colors.blue,
      borderRadius: storeController.currentTheme.value == 1?BorderRadius.circular(20):BorderRadius.circular(0),/////border radius of both sqaure and rectangle
      activeTrackColor: Colors.transparent,
      activeThumbColor: _activeThemeThumbColor(),
      // activeThumbColor: const Color.fromARGB(41,85,218,111),

      height: storeController.currentTheme.value == 4?60.0:70.0, ///////height of swipe square
      onSwipe: () async {
        if(swipeText == 'Swipe to Ready') {
          onSwipe!();
        } else{
          // route to launch screen
          Get.to(() => const LaunchRocket());
          await storeController.bluetoothScreen.buttonAction([0xA0, 0x01, 0x01, 0xA2]); //here we write data to bluetooth device to turn left light on
        }
        },
      // this container contains swipe to ready rectangle
      child: Container(
        // color: Colors.red,
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.16,
        // padding: EdgeInsets.only(left: 60.0,top: 12.0),
        decoration: BoxDecoration(
          boxShadow: storeController.currentTheme.value == 3?[BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),]:null,
          // color: Colors.red,
          color: storeController.currentTheme.value == 2?const Color.fromRGBO(0, 0, 0, 0.7):const Color.fromRGBO(0, 0, 0, 0.4), ///////////////color of swipe rectangle
          borderRadius: BorderRadius.all((storeController.currentTheme.value != 4)?const Radius.circular(15):Radius.zero ),////////////////////border radius of swipe rectangle
          border: storeController.currentTheme.value == 1?Border.all(color: Colors.blue,width: 2.0):Border.all(color: Colors.transparent),/////border color and width of swipe rectangle
            // BorderSide(color: Colors.white, width: 2.0):BorderSide(color: Colors.transparent)
        ),
        child: Center(
          child: SwipeTextAnimation(text: swipeText),
        ),
      ),
    ));
  }

  /*
  here it returns the slider image or icon for specific theme
   */
  Widget _thumbImageOrIcon(){
    if(storeController.currentTheme.value == 1){
      return Image.asset('assets/images/swipe_image.png');
    }
    else{
      return Container(
          decoration: BoxDecoration(
            color: storeController.currentTheme.value != 3?Colors.black:null,
            border: Border.all(width: 5,color: Colors.black),////////////////////////////////////////////////width of square swipe
            borderRadius: storeController.currentTheme.value == 4?null:const BorderRadius.all(Radius.circular(15)),// border radius of square swipe
          ),
          child: Icon(Icons.arrow_forward_ios_rounded,size: 40,color: Colors.grey,opticalSize: 10,));
    }
  }

  /*
  this returns the swipe container background color
   */
  Color _activeThemeThumbColor(){
    if(storeController.currentTheme.value == 1){
      return Colors.blue;
    }
    else{
      return Colors.transparent;
    }
  }
}

import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BackgroundLoad extends StatelessWidget {

  StoreController storeController = Get.find<StoreController>();
  final BuildContext context;
  BackgroundLoad({super.key,required this.context});

  // final Rx<int> currentTheme;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (storeController.currentTheme == 2) {
        return Transform.scale(
          scaleY: 1.7,
          scaleX: 1.4,
          // scale: 1.0,
          child: backgroundImageContainer(),
        );
      }
      if (storeController.currentTheme == 3) {
        return backgroundImageContainer();
      }
      if (storeController.currentTheme == 4) {
        return backgroundImageContainer();
      } else {
        return SizedBox();
      }
    });
  }
  Container backgroundImageContainer() {
    return Container(
      constraints: const BoxConstraints.expand(),
      width: MediaQuery.of(context).size.width ,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          opacity: 0.65,
          image: backgroundImage(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  AssetImage backgroundImage() {
      return AssetImage('assets/images/${storeController.currentBackground}.png');
  }
}

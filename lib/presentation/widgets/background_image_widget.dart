import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class BackgroundLoad extends StatelessWidget {
  BackgroundLoad({super.key,required this.context});

  final StoreController storeController = Get.find<StoreController>();
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (storeController.currentTheme.value == 2) {
        return Transform.scale(
          scaleY: 1.7,
          scaleX: 1.4,
          // scale: 1.0,
          child: _backgroundImageContainer(),
        );
      }
      if (storeController.currentTheme.value == 3) {
        return _backgroundImageContainer();
      }
      if (storeController.currentTheme.value == 4) {
        return _backgroundImageContainer();
      } else {
        return _backgroundImageContainer();
      }
    });
  }

  /*
  background image will returned in a container with max width and height of device
   */
  Container _backgroundImageContainer() {
    return Container(
      constraints: const BoxConstraints.expand(),
      width: MediaQuery.of(context).size.width ,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          // opacity: 0.8,
          image: _backgroundImage(),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.6),
            BlendMode.dstATop,
          ),
        ),
      ),
    );
  }

  /*
  background image is retrieved from getX controller which is setted with theme in settings.
   */
  ImageProvider _backgroundImage() {
      if(storeController.currentTheme > 4){
        return FileImage(File(storeController.currentBackgroundPath.value));
      }
      return AssetImage('assets/images/${storeController.currentBackground}');
  }
}

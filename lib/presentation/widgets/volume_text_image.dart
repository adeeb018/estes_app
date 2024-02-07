import 'package:flutter/material.dart';
import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class VolumeToMax extends StatelessWidget {
  VolumeToMax({super.key});

  StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
      return Obx((){
        if(storeController.currentTheme == 1) {
          return Image.asset('assets/images/sound_image_1.png');
        } else if(storeController.currentTheme == 2){
          return Image.asset('assets/images/sound_image_2.png');
        } else if(storeController.currentTheme == 3){
          return Image.asset('assets/images/sound_image_3.png');
        }
        else{
          return const SizedBox();
        }
      });
  }
}

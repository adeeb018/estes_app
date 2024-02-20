import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';

class LoadRocketLaunchAnimation extends StatelessWidget {
  LoadRocketLaunchAnimation({
    super.key,
    required AnimationController rocketAnimationController,
  }) : _rocketAnimationController = rocketAnimationController;

  final AnimationController _rocketAnimationController;

  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (storeController.currentTheme.value == 1) {
        return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Lottie.asset('assets/animations/rocket_animation.json',controller: _rocketAnimationController)
//Image.asset('assets/images/launch_rocket.png'),
        );
      }
      if (storeController.currentTheme.value == 2) {
        return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Image.asset('assets/images/rocket_animation_2.png')
//Image.asset('assets/images/launch_rocket.png'),
        );
      }
      if (storeController.currentTheme.value == 3) {
        return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Image.asset('assets/images/rocket_animation_3.png')
//Image.asset('assets/images/launch_rocket.png'),
        );
      }
      if (storeController.currentTheme.value == 4) {
        return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/images/rocket_animation_4_stack_1.png'),
                Image.asset('assets/images/rocket_animation_4_stack_2.png',height: MediaQuery.of(context).size.height/7,),
              ],
            )
//Image.asset('assets/images/launch_rocket.png'),
        );
      }
      else {
        return SizedBox();
      }
    });
  }
}



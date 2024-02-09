import 'package:flutter/material.dart';
import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:get/get.dart';
class PageThemeOne extends StatelessWidget {
  PageThemeOne({super.key, required this.currentView});

  final StoreController storeController = Get.find<StoreController>();
  final int currentView;

  @override
  Widget build(BuildContext context) {//////////////////////////////////With repect the current Them different elements are returned from here on some instances
    return Obx(() {                   /////////////////////////////////there is only a fixed sizedBox to fill out the portions in the mainpage.
      if (storeController.currentTheme == 1) {
        return Container(
          alignment: Alignment.bottomCenter,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _rotatingContainer(currentView),
              Image.asset("assets/images/rocket_1.png"),
            ],
          ),
        );
      }
      else if (storeController.currentTheme == 2) {
        return const SizedBox(
          height: 300,
          width: 300,
        );
      }
      else if(storeController.currentTheme == 3){
        return Container(
          // color: Colors.red,
          height: 300,
          width:MediaQuery.of(context).size.width,
          child: Image.asset('assets/images/astronaut_1.png',alignment: Alignment.bottomCenter,),
        );
      }
      else {
        return const SizedBox(
          height: 300,
          width: 300,
        );
      }
    });

  }

  /*
  a rotating container is builder for first theme
  this container rotated on changing the currentView in Corousal
   */
  Builder _rotatingContainer(int pos) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: Colors.black,
          child: AnimatedRotation(
            turns: pos / 4,
            duration: const Duration(seconds: 2),
            child: Image.asset("assets/images/group_1.png"),
          ),
        );
      },
    );
  }
}
